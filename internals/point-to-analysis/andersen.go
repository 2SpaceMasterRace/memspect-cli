package main

import (
    "encoding/json"
    "fmt"
    "os"
)

type PointsToSets map[string]map[string][]string

func main() {
    data, err := os.ReadFile("results.json")
    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }

    var pointsToSets PointsToSets
    err = json.Unmarshal(data, &pointsToSets)
    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }

    newPointsToSets := make(PointsToSets)
    for k, v := range pointsToSets {
        newPointsToSets[k] = make(map[string][]string)
        for k2, v2 := range v {
            newPointsToSets[k][k2] = append([]string{}, v2...)
        }
    }

    // Iterate until a fixed point is reached
    for changed := true; changed; {
        changed = false
        for functionName, function := range pointsToSets {
            for variable, pointsTo := range function {
                for _, value := range pointsTo {
                    if value[0] == '%' {
                        for _, value2 := range function[value] {
                            if !contains(newPointsToSets[functionName][variable], value2) {
                                newPointsToSets[functionName][variable] = append(newPointsToSets[functionName][variable], value2)
                                changed = true
                            }
                        }
                    }
                }
            }
        }
        pointsToSets = newPointsToSets
    }

    // Print the graph representation
    printGraph(pointsToSets)
}

func printGraph(pointsToSets PointsToSets) {
    for functionName, function := range pointsToSets {
        fmt.Printf("Function: %s\n", functionName)
        for variable, pointsTo := range function {
            fmt.Printf("  %s -> ", variable)
            for _, target := range pointsTo {
                fmt.Printf("%s ", target)
            }
            fmt.Println()
        }
        fmt.Println()
    }
}

func contains(slice []string, item string) bool {
    for _, value := range slice {
        if value == item {
            return true
        }
    }
    return false
}