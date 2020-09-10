package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func AwsomeServer(w http.ResponseWriter, r *http.Request) {
	NAME := "JOE"
	fmt.Fprintf(w, "Hello, %s!", NAME)
}

func main() {
	log.SetOutput(os.Stdout)
	addr := ":8080"

	log.Println("Server suppose to start on addr: ", addr)
	http.HandleFunc("/", AwsomeServer)
	http.ListenAndServe(addr, nil)
}
