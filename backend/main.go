package main

import (
	"skillmatch-backend/config"
	"skillmatch-backend/models"
	"skillmatch-backend/routes"

	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()

	// Connect to database
	config.ConnectDatabase()

	// Auto migrate
	config.DB.AutoMigrate(&models.User{})

	// Register modular routes
	routes.RegisterApiRoutes(e)

	// Start server
	e.Logger.Fatal(e.Start(":8080"))
}
