to enable debugging:

each library side:
1. (in cmake) need to pass through the source directory that was used for the library using cmake to create a param file and install it

app side:
1. (in nix devshell) create the file that combines all of the dependency library directories from each one of their debug folders 
2. (in nix devshell) create / use a script that will create the source map from the dependent library locations on the user machine and align them with the source build directories and write the launch.json to the user's .vscode directory
