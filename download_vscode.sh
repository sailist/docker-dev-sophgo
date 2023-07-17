commit=704ed70d4fd1c6bd6342c436f1ede30d1cff4710
 
echo ""
 
if [ ! -d "install-vscode-server/bin/$commit" ] ; then
    mkdir -p install-vscode-server/bin
    cd install-vscode-server/bin
    wget -c https://update.code.visualstudio.com/commit:$commit/server-linux-x64/stable
    tar -xf stable
    mv vscode-server-linux-x64 $commit
    echo "vscode server commit:$commit installed"
else
    echo "Commit already installed"
fi
 
echo ""