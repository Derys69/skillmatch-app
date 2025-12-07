package utils

import (
	"time"

	"github.com/golang-jwt/jwt/v5"
)

var JWT_SECRET = []byte("SKILLMATCH-SECRET-123")

func GenerateToken(userId uint) (string, error) {
	claims := jwt.MapClaims{
		"user_id": userId,
		"exp":     time.Now().Add(time.Hour * 24).Unix(),
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	return token.SignedString(JWT_SECRET)
}
