package main

import "net/http"

func main() {
    handler := func(w http.ResponseWriter, r *http.Request) {
        if r.URL.Path == "/" || r.URL.Path == "/hello" {
            w.Header().Set("Content-Type", "text/plain")
            w.WriteHeader(200)
            w.Write([]byte("hello world"))
            return
        }
        w.WriteHeader(404)
    }

    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}
