# protoc --proto_path=./proto --go_out==import_path=${pkg},plugins=grpc:./service --go_opt=paths=source_relative proto/*/*.proto 
# protoc --proto_path=./proto --go_out=./service --go_opt=paths=source_relative proto/$(basename "$dir")/*/*.proto
# protoc --proto_path=./proto --go-grpc_out=. --go-grpc_opt=paths=source_relative proto/*/*.proto 
#!/bin/bash

export PATH="$PATH:$(go env GOPATH)/bin"

for dir in $(pwd)/proto/*/
do
  basename "$dir"
  protoc --proto_path=./proto --go_out=./service --go_opt=paths=source_relative proto/$(basename "$dir")/*/*.proto
done

for dir in $(pwd)/proto/*/
do

  basename "$dir"
  serviceFile=proto/$(basename "$dir")/service.proto
  if [ -f "$serviceFile" ]; then
    protoc --proto_path=./proto --go-grpc_out=./service --go-grpc_opt=paths=import $serviceFile
  fi
done
