package middleware

import (
	"net/http"
	"strings"

	"skillmatch-backend/config"
	"skillmatch-backend/models"
	"skillmatch-backend/utils"

	"github.com/golang-jwt/jwt/v5"
	"github.com/labstack/echo/v4"
)

func JWTMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {

		authHeader := c.Request().Header.Get("Authorization")

		if authHeader == "" {
			return c.JSON(http.StatusUnauthorized, echo.Map{
				"message": "Missing token",
			})
		}

		tokenString := strings.Replace(authHeader, "Bearer ", "", 1)

		token, err := jwt.Parse(tokenString, func(t *jwt.Token) (interface{}, error) {
			return utils.JWT_SECRET, nil
		})

		if err != nil || !token.Valid {
			return c.JSON(http.StatusUnauthorized, echo.Map{
				"message": "Invalid or expired token",
			})
		}

		claims := token.Claims.(jwt.MapClaims)
		userID := uint(claims["user_id"].(float64))

		var user models.User
		if err := config.DB.First(&user, userID).Error; err != nil {
			return c.JSON(http.StatusUnauthorized, echo.Map{
				"message": "User not found",
			})
		}

		c.Set("user", user)

		return next(c)
	}
}
