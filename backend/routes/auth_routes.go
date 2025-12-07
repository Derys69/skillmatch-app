package routes

import (
	"skillmatch-backend/handlers"

	"github.com/labstack/echo/v4"
)

func AuthRoutes(e *echo.Echo) {
	auth := e.Group("/auth")

	auth.POST("/register", handlers.Register)
	auth.POST("/login", handlers.Login)
}
