--
-- premake5 file to build open-dis-cpp
-- http://premake.github.io/
--

workspace "open-dis-cpp"
  configurations {
    "Debug",
    "Release"
  }
  targetdir "Build/lib/%{cfg.buildcfg}"
  configuration "Debug*"
    defines { "DEBUG" }

  configuration "Release*"
    defines { "NDEBUG" }
    optimize "On"

  configuration "windows"
    defines { "WIN32", "EXPORT_LIBRARY" }

  configuration { "linux", "gmake" }
    buildoptions {
      "-Wall"
      -- "-Werror" -- Turning this on causes many compiler errors.
    }

project "OpenDIS"
  language "C++"
  kind "SharedLib"
  includedirs {
    "src"
  }
  files {
    "src/dis6/*.h",
    "src/dis6/*.cpp",
    "src/utils/*.h",
    "src/utils/*.cpp"
  }

-- Uncomment this if you have the HawkNL library and want to build the example.

project "ExampleSender"
  language "C++"
  kind "ConsoleApp"
  includedirs {
    "src",
    "."
  }
  files {
    "examples/main.cpp",
    "examples/Connection.*",
    "examples/Utils.*",
    "examples/Timer.*"
  }
  links { "OpenDIS", "SDL2", "SDL2_net" }

project "ExampleReciever"
  language "C++"
  kind "ConsoleApp"
  includedirs {
    "src",
    "."
  }
  files {
    "examples/main_receive.cpp",
    "examples/Connection.*",
    "examples/Utils.*",
    "examples/Timer.*",
	"examples/EntityStatePduProcessor.*"
  }
  links { "OpenDIS", "SDL2", "SDL2_net" }


-- TODO: add project sections for the unit tests and the examples.
