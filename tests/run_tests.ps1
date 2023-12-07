# This script creates a build directory as a peer of cmaked2,
# and builds the tests there.

$CMAKE_DIR = Join-Path (Get-Location) '../cmake-d'
$TEST_DIR = Join-Path (Get-Location) '../../cmake-d-test-build'

Remove-Item -Path $TEST_DIR -Recurse -Force
New-Item -Path $TEST_DIR -ItemType Directory | Out-Null
Set-Location $TEST_DIR

# Do an unspecified build
New-Item -Path 'unspecified' -ItemType Directory | Out-Null
Set-Location 'unspecified'
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR ../../cmake-d/tests
cmake --build .
ctest
Set-Location ..

# Do a debug build
New-Item -Path 'debug' -ItemType Directory | Out-Null
Set-Location 'debug'
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR -DCMAKE_VERBOSE_MAKEFILE=1 -DCMAKE_BUILD_TYPE=Debug ../../cmake-d/tests
cmake --build .
ctest
Set-Location ..

# Do a release build
New-Item -Path 'release' -ItemType Directory | Out-Null
Set-Location 'release'
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR -DCMAKE_BUILD_TYPE=Release ../../cmake-d/tests
cmake --build .
ctest
Set-Location ..

# Do a relWithDebInfo build
New-Item -Path 'relWithDebInfo' -ItemType Directory | Out-Null
Set-Location 'relWithDebInfo'
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR -DCMAKE_BUILD_TYPE=RelWithDebInfo ../../cmake-d/tests
cmake --build .
ctest
Set-Location ..

# Do a minSizeRel build
New-Item -Path 'minSizeRel' -ItemType Directory | Out-Null
Set-Location 'minSizeRel'
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR -DCMAKE_BUILD_TYPE=MinSizeRel ../../cmake-d/tests
cmake --build .
ctest
Set-Location ..
