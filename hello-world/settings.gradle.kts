rootProject.name = "example"
enableFeaturePreview("TYPESAFE_PROJECT_ACCESSORS")

pluginManagement {
    repositories {
        System.getenv("MAVEN_SOURCE_REPOSITORY")?.let {
            maven(it) {
                metadataSources {
                    gradleMetadata()
                    mavenPom()
                    artifact()
                }
            }
        } ?: gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositories {
        System.getenv("MAVEN_SOURCE_REPOSITORY")?.let {
            maven(it) {
                metadataSources {
                    gradleMetadata()
                    mavenPom()
                    artifact()
                }
            }
        } ?: mavenCentral()
    }
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
}


plugins {
    `gradle-enterprise`
}

gradleEnterprise {
    buildScan {
        termsOfServiceUrl = "https://gradle.com/terms-of-service"
        termsOfServiceAgree = "yes"
    }
}
