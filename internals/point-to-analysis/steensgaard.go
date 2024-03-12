package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// Node represents a node in the control flow graph (CFG)
type Node struct {
	Instructions []string
	Successors   []*Node
}

// CFG represents the control flow graph
type CFG []*Node

// PointsToSet represents a set of pointers that can point to the same memory location
type PointsToSet map[*Node]bool

// PointsToGraph maps pointers to their corresponding points-to sets
type PointsToGraph map[*Node]PointsToSet

// UnionFind is a data structure used to solve the constraints
type UnionFind struct {
	parent map[*Node]*Node
	ranks  map[*Node]int
}

// NewUnionFind creates a new UnionFind data structure
func NewUnionFind() *UnionFind {
	return &UnionFind{
		parent: make(map[*Node]*Node),
		ranks:  make(map[*Node]int),
	}
}

// Find returns the representative element of the set that x is a member of
func (uf *UnionFind) Find(x *Node) *Node {
	if uf.parent[x] == nil {
		uf.parent[x] = x
		uf.ranks[x] = 0
	}

	if uf.parent[x] != x {
		uf.parent[x] = uf.Find(uf.parent[x])
	}

	return uf.parent[x]
}

// Union merges the sets containing x and y
func (uf *UnionFind) Union(x, y *Node) {
	xRoot := uf.Find(x)
	yRoot := uf.Find(y)

	if xRoot == yRoot {
		return
	}

	if uf.ranks[xRoot] < uf.ranks[yRoot] {
		uf.parent[xRoot] = yRoot
	} else if uf.ranks[xRoot] > uf.ranks[yRoot] {
		uf.parent[yRoot] = xRoot
	} else {
		uf.parent[yRoot] = xRoot
		uf.ranks[xRoot]++
	}
}

// parseLLVMIR parses the LLVM IR file and returns the control flow graph (CFG)
func parseLLVMIR(filePath string) (CFG, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	cfg := make(CFG, 0)
	currentNode := &Node{}

	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "define") || strings.HasPrefix(line, "declare") {
			// Start of a new function, create a new node
			currentNode = &Node{}
			cfg = append(cfg, currentNode)
		} else if strings.HasPrefix(line, "  ") {
			// Instruction, add it to the current node
			currentNode.Instructions = append(currentNode.Instructions, line)
		} else if line == "}" {
			// End of a function, handle control flow
			handleControlFlow(currentNode)
		}
	}

	if err := scanner.Err(); err != nil {
		return nil, err
	}

	return cfg, nil
}

// handleControlFlow updates the control flow graph based on the instructions
func handleControlFlow(node *Node) {
	for _, instr := range node.Instructions {
		if strings.HasPrefix(instr, "br") {
			// Handle branch instruction
			handleBranch(node, instr)
		}
		// Add other control flow instructions here (e.g., switch, ret)
	}
}

// handleBranch updates the control flow graph based on the branch instruction
func handleBranch(node *Node, instr string) {
	parts := strings.Split(instr, " ")
	if len(parts) < 3 {
		return
	}

	condition := parts[1]
	trueDest := parts[2]
	falseDest := parts[3]

	trueNode := &Node{}
	falseNode := &Node{}

	node.Successors = append(node.Successors, trueNode, falseNode)

	// Update the true and false destinations based on the condition
	if condition != "label" {
		// Swap true and false destinations if the condition is false
		trueNode, falseNode = falseNode, trueNode
	}

	trueLabel := strings.TrimSuffix(trueDest, ",")
	falseLabel := strings.TrimSuffix(falseDest, ",")

	// Find the nodes corresponding to the true and false labels
	for _, n := range node.Successors {
		if strings.HasPrefix(n.Instructions[0], trueLabel) {
			trueNode = n
		} else if strings.HasPrefix(n.Instructions[0], falseLabel) {
			falseNode = n
		}
	}
}

func handleBranch(node *Node, instr string) {
	parts := strings.Split(instr, " ")
	if len(parts) < 3 {
		return
	}

	condition := parts[1]
	trueDest := parts[2]
	falseDest := parts[3]

	trueNode := &Node{}
	falseNode := &Node{}

	node.Successors = append(node.Successors, trueNode, falseNode)

	// Update the true and false destinations based on the condition
	if condition != "label" {
		// Swap true and false destinations if the condition is false
		trueNode, falseNode = falseNode, trueNode
	}

	trueLabel := strings.TrimSuffix(trueDest, ",")
	falseLabel := strings.TrimSuffix(falseDest, ",")

	// Find the nodes corresponding to the true and false labels
	for _, n := range node.Successors {
		if strings.HasPrefix(n.Instructions[0], trueLabel) {
			trueNode = n
		} else if strings.HasPrefix(n.Instructions[0], falseLabel) {
			falseNode = n
		}
	}
}

// handleReturn updates the control flow graph based on the return instruction
func handleReturn(node *Node, instr string) {
	// Add termination logic for the node
	// For example, you could create a special "Exit" node and make it the successor of the current node
	exitNode := &Node{}
	node.Successors = append(node.Successors, exitNode)
}

// steensgaardPointerAnalysis performs Steensgaard's pointer analysis on the CFG
func steensgaardPointerAnalysis(cfg CFG) (PointsToGraph, error) {
	pointsToGraph := make(PointsToGraph)
	constraints := buildConstraints(cfg)
	pointsToSets := solveConstraints(constraints)

	for ptr, pointsToSet := range pointsToSets {
		pointsToGraph[ptr] = pointsToSet
	}

	return pointsToGraph, nil
}

// buildConstraints builds the constraints based on the CFG
func buildConstraints(cfg CFG) map[*Node]map[*Node]bool {
	constraints := make(map[*Node]map[*Node]bool)

	for _, node := range cfg {
		for _, instr := range node.Instructions {
			parts := strings.Split(instr, " = ")
			if len(parts) < 2 {
				continue
			}

			lhs := parsePointer(parts[0])
			rhs := parsePointer(parts[1])

			if lhs != nil && rhs != nil {
				if _, ok := constraints[lhs]; !ok {
					constraints[lhs] = make(map[*Node]bool)
				}
				constraints[lhs][rhs] = true

				if _, ok := constraints[rhs]; !ok {
					constraints[rhs] = make(map[*Node]bool)
				}
				constraints[rhs][lhs] = true
			}
		}
	}

	return constraints
}

// parsePointer parses a pointer from a string representation
func parsePointer(s string) *Node {
	if strings.HasPrefix(s, "%") {
		i, err := strconv.Atoi(s[1:])
		if err == nil {
			return &Node{Instructions: []string{fmt.Sprintf("%v", i)}}
		}
	}
	return nil
}

// solveConstraints solves the constraints using union-find data structure
func solveConstraints(constraints map[*Node]map[*Node]bool) map[*Node]PointsToSet {
	uf := NewUnionFind()
	pointsToSets := make(map[*Node]PointsToSet)

	for ptr, related := range constraints {
		for rel := range related {
			uf.Union(ptr, rel)
		}
	}

	for ptr := range constraints {
		root := uf.Find(ptr)
		if _, ok := pointsToSets[root]; !ok {
			pointsToSets[root] = make(PointsToSet)
		}
		pointsToSets[root][ptr] = true
	}

	return pointsToSets
}

// buildPointsToGraph builds the points-to graph from the points-to sets
func buildPointsToGraph(pointsToSets map[*Node]PointsToSet) PointsToGraph {
	pointsToGraph := make(PointsToGraph)
	for ptr, pointsToSet := range pointsToSets {
		pointsToGraph[ptr] = pointsToSet
	}
	return pointsToGraph
}

// formatPointsToGraph formats the points-to graph for printing
func formatPointsToGraph(pointsToGraph PointsToGraph) string {
	var sb strings.Builder
	for ptr, pointsToSet := range pointsToGraph {
		sb.WriteString(fmt.Sprintf("%v points to: ", ptr.Instructions[0]))
		first := true
		for node := range pointsToSet {
			if !first {
				sb.WriteString(", ")
			}
			sb.WriteString(node.Instructions[0])
			first = false
		}
		sb.WriteString("\n")
	}
	return sb.String()
}

func main() {
	// Get the LLVM IR file path from the command line arguments
	if len(os.Args) < 2 {
		fmt.Println("Usage: go run main.go <llvm_ir_file>")
		return
	}
	llvmIRFilePath := os.Args[1]

	// Parse the LLVM IR file
	cfg, err := parseLLVMIR(llvmIRFilePath)
	if err != nil {
		fmt.Printf("Error parsing LLVM IR file: %v\n", err)
		return
	}

	// Perform Steensgaard's pointer analysis
	pointsToGraph, err := steensgaardPointerAnalysis(cfg)
	if err != nil {
		fmt.Printf("Error performing pointer analysis: %v\n", err)
		return
	}

	// Format and print the points-to graph
	formattedGraph := formatPointsToGraph(pointsToGraph)
	fmt.Println(formattedGraph)
}
