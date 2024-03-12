package main

import (
	"fmt"
	"os"
	"sort"
	"strings"
)

// Node represents a variable or object in the points-to graph
type Node struct {
	name     string
	pointsTo map[string]bool
}

// PointsToGraph represents the points-to graph
type PointsToGraph struct {
	nodes map[string]Node
}

// NewPointsToGraph initializes a new points-to graph
func NewPointsToGraph() *PointsToGraph {
	return &PointsToGraph{
		nodes: make(map[string]Node),
	}
}

// AddNode adds a new node to the points-to graph
func (ptg *PointsToGraph) AddNode(name string) {
	if _, exists := ptg.nodes[name]; !exists {
		ptg.nodes[name] = Node{name: name, pointsTo: make(map[string]bool)}
	}
}

// AddPointsTo adds a points-to relation between two nodes
func (ptg *PointsToGraph) AddPointsTo(from, to string) {
	fromNode, exists := ptg.nodes[from]
	if !exists {
		fromNode = Node{name: from, pointsTo: make(map[string]bool)}
	}
	fromNode.pointsTo[to] = true
	ptg.nodes[from] = fromNode
}

// AndersenAnalysis performs Andersen's pointer analysis on the given LLVM IR
func AndersenAnalysis(llvmIRCode string) *PointsToGraph {
	// Parse LLVM IR code
	instructions, err := parseIR(llvmIRCode)
	if err != nil {
		fmt.Printf("Error parsing LLVM IR: %v\n", err)
		os.Exit(1)
	}

	// Construct the initial points-to graph
	ptg := NewPointsToGraph()

	// Populate the points-to graph from the parsed instructions
	for _, inst := range instructions {
		handleInstruction(ptg, inst)
	}

	// Perform iterative propagation of points-to information
	workList := make([]Node, 0)
	for _, node := range ptg.nodes {
		workList = append(workList, node)
	}

	for len(workList) > 0 {
		currNode := workList[0]
		workList = workList[1:]

		for pointsTo := range currNode.pointsTo {
			pointsToNode, exists := ptg.nodes[pointsTo]
			if !exists {
				continue
			}

			for otherNodeName, otherNode := range ptg.nodes {
				if !otherNode.pointsTo[pointsToNode.name] {
					otherNode.pointsTo[pointsToNode.name] = true
					ptg.nodes[otherNodeName] = otherNode
					workList = append(workList, otherNode)
				}
			}
		}
	}

	return ptg
}

// parseIR parses the LLVM IR code and returns a slice of instructions
func parseIR(llvmIRCode string) ([]Instruction, error) {
	instructions := make([]Instruction, 0)
	lines := strings.Split(llvmIRCode, "\n")

	currentInst := Instruction{}
	for _, line := range lines {
		line = strings.TrimSpace(line)
		if line == "" || strings.HasPrefix(line, ";") {
			continue
		}

		if strings.Contains(line, "=") {
			// Instruction definition
			parts := strings.Split(line, "=")
			currentInst.Name = strings.TrimSpace(parts[0])
			currentInst.Operands = strings.Split(strings.TrimSpace(parts[1]), " ")
			instructions = append(instructions, currentInst)
			currentInst = Instruction{}
		} else {
			// Instruction continuation
			currentInst.Operands = append(currentInst.Operands, strings.TrimSpace(line))
		}
	}

	return instructions, nil
}

// handleInstruction processes an LLVM IR instruction and updates the points-to graph
func handleInstruction(ptg *PointsToGraph, inst Instruction) {
	switch inst.Name {
	case "alloca":
		ptg.AddNode(inst.Operands[0])

	case "load":
		srcPtr := inst.Operands[1]
		dest := inst.Operands[0]
		ptg.AddNode(srcPtr)
		ptg.AddNode(dest)
		ptg.AddPointsTo(srcPtr, dest)

	case "store":
		val := inst.Operands[0]
		dstPtr := inst.Operands[1]
		ptg.AddNode(val)
		ptg.AddNode(dstPtr)
		ptg.AddPointsTo(val, dstPtr)

	case "getelementptr":
		ptg.AddNode(inst.Operands[0])
		for _, op := range inst.Operands[1:] {
			ptg.AddNode(op)
			ptg.AddPointsTo(op, inst.Operands[0])
		}

	case "call":
		calledFunc := inst.Operands[1]
		switch calledFunc {
		case "malloc":
			ptg.AddNode(inst.Operands[0])
		case "free":
			ptrToFree := inst.Operands[1]
			ptg.AddNode(ptrToFree)
		default:
			ptg.AddNode(inst.Operands[0])
			for _, arg := range inst.Operands[2:] {
				ptg.AddNode(arg)
				ptg.AddPointsTo(arg, inst.Operands[0])
			}
		}

	default:
		ptg.AddNode(inst.Operands[0])
		for _, op := range inst.Operands[1:] {
			ptg.AddNode(op)
			ptg.AddPointsTo(op, inst.Operands[0])
		}
	}
}

// Instruction represents an LLVM IR instruction
type Instruction struct {
	Name     string
	Operands []string
}

func main() {
	// Get the LLVM IR file path from command-line arguments
	if len(os.Args) < 2 {
		fmt.Println("Usage: go run main.go <llvm_ir_file_path>")
		os.Exit(1)
	}

	llvmIRFilePath := os.Args[1]

	// Read the LLVM IR code from the file
	llvmIRCode, err := os.ReadFile(llvmIRFilePath)
	if err != nil {
		fmt.Printf("Error reading LLVM IR file: %v\n", err)
		os.Exit(1)
	}

	ptg := AndersenAnalysis(string(llvmIRCode))

	// Print the points-to graph
	for _, node := range ptg.nodes {
		fmt.Printf("%%%s points to: ", node.name)

		pointsTo := make([]string, 0, len(node.pointsTo))
		for p := range node.pointsTo {
			pointsTo = append(pointsTo, "%"+p)
		}

		sort.Strings(pointsTo) // Sort pointsTo for consistent output

		if len(pointsTo) > 0 {
			fmt.Printf("%s\n", strings.Join(pointsTo, ", "))
		} else {
			fmt.Println("no points")
		}
	}
}

