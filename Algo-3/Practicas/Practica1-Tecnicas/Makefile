BINARY_NAME=Executable.out

all: run clean

build:
	@go build -o ${BINARY_NAME} .
run:
	@go build -o ${BINARY_NAME} .
	@./${BINARY_NAME}
clean:
	@go clean
	@rm ${BINARY_NAME}