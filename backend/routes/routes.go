package routes

import (
	"skillmatch-backend/handlers"
	jwtmid "skillmatch-backend/middleware"

	"github.com/labstack/echo/v4"
)

func SetupRoutes(e *echo.Echo) {

	// Auth routes (public)
	auth := e.Group("/auth")
	auth.POST("/register", handlers.Register)
	auth.POST("/login", handlers.Login)

	// User routes (protected)
	user := e.Group("/users")
	user.Use(jwtmid.JWTMiddleware)

	user.GET("/me", handlers.GetMe)
	user.PUT("/update", handlers.UpdateProfile)
}
