# Build NuGet library, add to $NUGET_LOCAL_PACKAGE_SOURCE (use configgedit)
function build_local_nuget
    if not dotnet pack -c Release
        return 1
    end
    
    if not test -d ./bin/Release
        return 2
    end
    
    if not set -l package (ls -t ./bin/Release/*.nupkg)
        return 3
    end
    
    if test -z $CONFIG_NUGET_LOCAL_PACKAGE_SOURCE
        echo "run configgedit and add CONFIG_NUGET_LOCAL_PACKAGE_SOURCE (path to local package source)"
        return 4
    end
    
    if not test -d $CONFIG_NUGET_LOCAL_PACKAGE_SOURCE
        echo "CONFIG_NUGET_LOCAL_PACKAGE_SOURCE is not an existing path.  run configgedit and modify."
        return 4
    end
    
    cp $package $CONFIG_NUGET_LOCAL_PACKAGE_SOURCE
    echo "copied $package to $CONFIG_NUGET_LOCAL_PACKAGE_SOURCE"
end

