package main

import (
	"io/ioutil"
	"net/http/httptest"
	"testing"
)

func TestAwsomeServer(t *testing.T) {
	const expectedResponse = "Hello, MIKE!"

	mockRecorder := httptest.NewRecorder()
	mockRequest := httptest.NewRequest("GET", "/", nil)
	AwsomeServer(mockRecorder, mockRequest)

	resp := mockRecorder.Result()
	body, _ := ioutil.ReadAll(resp.Body)

	if string(body) != expectedResponse {
		t.Errorf("'%s' does not match with expected: '%s'", body, expectedResponse)
	}
}
