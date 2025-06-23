package main

import (
	"fmt"
	"log"
	"os"
	"sync"
	"time"
)

// Author: Nabin

var (
	taskQueue   = make(chan string, 20)
	resultList  = []string{}
	mutex       sync.Mutex
	logFile     *os.File
	waitGroup   sync.WaitGroup
)

func init() {
	var err error
	logFile, err = os.OpenFile("log_go.txt", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
	if err != nil {
		log.Fatal("Cannot open log file:", err)
	}
	log.SetOutput(logFile)
}

// Worker function simulates ride processing
func worker(id int) {
	defer waitGroup.Done()
	log.Printf("Goroutine %d started.\n", id)
	for task := range taskQueue {
		time.Sleep(500 * time.Millisecond) // simulate processing
		result := fmt.Sprintf("Goroutine %d processed: %s", id, task)

		// Safely append result
		mutex.Lock()
		resultList = append(resultList, result)
		mutex.Unlock()

		log.Println(result)
	}
	log.Printf("Goroutine %d finished.\n", id)
}

func main() {
	defer logFile.Close()

	// Add tasks to queue
	for i := 1; i <= 20; i++ {
		taskQueue <- fmt.Sprintf("Ride Request %d", i)
	}
	close(taskQueue)

	// Start 4 workers
	for i := 0; i < 4; i++ {
		waitGroup.Add(1)
		go worker(i)
	}

	waitGroup.Wait()

	// Save results to file
	resultFile, err := os.Create("results_go.txt")
	if err != nil {
		log.Println("Error creating result file:", err)
		return
	}
	defer resultFile.Close()

	for _, res := range resultList {
		fmt.Fprintln(resultFile, res)
	}
}
