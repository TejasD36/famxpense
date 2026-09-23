import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.tejasd.famxpense"
            resValue(type = "string", name = "app_name", value = "FamXpense")
        }
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.tejasd.famxpense.dev"
            resValue(type = "string", name = "app_name", value = "FamXpense Dev")
        }
    }

    buildFeatures.resValues = true
}