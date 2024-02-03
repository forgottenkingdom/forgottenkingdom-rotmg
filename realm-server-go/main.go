package main

import (
	"embed"
	"net/http"

	"github.com/gin-gonic/gin"
)

//go:embed static/*
var staticFiles embed.FS

func main() {
	r := gin.Default()

	staticFS := http.FS(staticFiles)

	r.StaticFS("/public", staticFS)

	r.Run(":8080")
}
