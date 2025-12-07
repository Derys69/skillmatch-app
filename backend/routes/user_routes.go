package routes

import (
	"skillmatch-backend/handlers"
	jwtmid "skillmatch-backend/middleware"

	"github.com/labstack/echo/v4"
)

func UserRoutes(e *echo.Echo) {
	user := e.Group("/users")

	// Protected routes
	user.Use(jwtmid.JWTMiddleware)

	user.GET("/me", handlers.GetMe)
	user.PUT("/update", handlers.UpdateProfile)
}
