package main

import (
	"context"
	"log"

	"github.com/hashicorp/terraform-plugin-framework/providerserver"

	graylog "github.com/Ultrafenrir/terraform-provider-graylog/internal/provider"
)

var (
	// Set by goreleaser or ldflags at build time if needed
	version = "dev"
)

func main() {
	if err := providerserver.Serve(
		context.Background(),
		graylog.NewWithVersion(version),
		providerserver.ServeOpts{
			Address: "registry.terraform.io/i-shulgan/graylog",
			Debug:   false,
			// ProtocolVersions: []int{6}, // framework will negotiate by default
		},
	); err != nil {
		log.Fatal(err)
	}
}
