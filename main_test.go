package main

import "testing"

func TestHelloMessage(t *testing.T) {
	got := helloMessage()
	want := "Hello, World!"

	if got != want {
		t.Fatalf("helloMessage() = %q, want %q", got, want)
	}
}
