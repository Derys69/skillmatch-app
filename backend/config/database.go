package config

import (
	"fmt"
	"log"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDatabase() {
	host := "localhost"
	user := "postgres"
	password := "123456"
	dbName := "skillmatch"
	port := "5432"

	dsn := fmt.Sprintf(
		"host=%s user=%s password=%s dbname=%s port=%s sslmode=disable",
		host, user, password, dbName, port,
	)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})

	if err != nil {
		log.Fatal("❌ Gagal connect DB:", err)
	}

	DB = db
	fmt.Println("Database connected!")
}
