file(GLOB ProtoFiles "${CMAKE_CURRENT_SOURCE_DIR}/proto/*.proto")
PROTOBUF_GENERATE_CPP(ProtoSources ProtoHeaders ${ProtoFiles})

add_library(mtalk_proto STATIC ${ProtoSources} ${ProtoHeaders})
target_include_directories(mtalk_proto INTERFACE ${CMAKE_CURRENT_BINARY_DIR})
target_link_libraries(mtalk_proto ${PROTOBUF_LIBRARIES})
