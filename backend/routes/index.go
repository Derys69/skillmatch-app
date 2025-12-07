package routes

import (
	"github.com/labstack/echo/v4"
)

func RegisterApiRoutes(e *echo.Echo) {
	// Register route modules
	AuthRoutes(e)
	UserRoutes(e)
}
