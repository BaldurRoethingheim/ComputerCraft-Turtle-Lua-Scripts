local success, data = turtle.inspect()
if success then
    print("Block name: ", data.name)
    print("Block metadata: ", data.metadata)
    print("Block state.type: ", data.state.type)
    print("Block state.stage: ", data.state.stage)
end       
