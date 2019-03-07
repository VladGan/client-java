# Do not edit. bazel-deps autogenerates this file from dependencies/maven/dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "ch.qos.logback:logback-classic:1.2.3", "lang": "java", "sha1": "7c4f3c474fb2c041d8028740440937705ebb473a", "sha256": "fb53f8539e7fcb8f093a56e138112056ec1dc809ebb020b59d8a36a5ebac37e0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar", "source": {"sha1": "cfd5385e0c5ed1c8a5dce57d86e79cf357153a64", "sha256": "480cb5e99519271c9256716d4be1a27054047435ff72078d9deae5c6a19f63eb", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3-sources.jar"} , "name": "ch-qos-logback-logback-classic", "actual": "@ch-qos-logback-logback-classic//jar", "bind": "jar/ch/qos/logback/logback-classic"},
    {"artifact": "ch.qos.logback:logback-core:1.2.3", "lang": "java", "sha1": "864344400c3d4d92dfeb0a305dc87d953677c03c", "sha256": "5946d837fe6f960c02a53eda7a6926ecc3c758bbdd69aa453ee429f858217f22", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar", "source": {"sha1": "3ebabe69eba0196af9ad3a814f723fb720b9101e", "sha256": "1f69b6b638ec551d26b10feeade5a2b77abe347f9759da95022f0da9a63a9971", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3-sources.jar"} , "name": "ch-qos-logback-logback-core", "actual": "@ch-qos-logback-logback-core//jar", "bind": "jar/ch/qos/logback/logback-core"},
    {"artifact": "com.google.api.grpc:proto-google-common-protos:1.0.0", "lang": "java", "sha1": "86f070507e28b930e50d218ee5b6788ef0dd05e6", "sha256": "cfe1da4c0e82820c32a83c4bf25b42f4d3b7113177321c437a9fff3c42e1f4c9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/api/grpc/proto-google-common-protos/1.0.0/proto-google-common-protos-1.0.0.jar", "source": {"sha1": "b48d52024623007eaf1a5636c28f3699a8a078a5", "sha256": "0d016cc4677bb7bb721ebf862f3cd07e7df9710a677c3412081887c786756d73", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/api/grpc/proto-google-common-protos/1.0.0/proto-google-common-protos-1.0.0-sources.jar"} , "name": "com-google-api-grpc-proto-google-common-protos", "actual": "@com-google-api-grpc-proto-google-common-protos//jar", "bind": "jar/com/google/api/grpc/proto-google-common-protos"},
    {"artifact": "com.google.code.findbugs:annotations:3.0.1", "lang": "java", "sha1": "fc019a2216218990d64dfe756e7aa20f0069dea2", "sha256": "6b47ff0a6de0ce17cbedc3abb0828ca5bce3009d53ea47b3723ff023c4742f79", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/annotations/3.0.1/annotations-3.0.1.jar", "source": {"sha1": "e6a834472bdb9f5c9b8ec64d05c3ae2cb6a03cec", "sha256": "1a64119813ca80a6ebef047190a4f62ee4ad44afe786e92d698ba7aa730ffc0a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/annotations/3.0.1/annotations-3.0.1-sources.jar"} , "name": "com-google-code-findbugs-annotations", "actual": "@com-google-code-findbugs-annotations//jar", "bind": "jar/com/google/code/findbugs/annotations"},
# duplicates in com.google.code.findbugs:jsr305 fixed to 2.0.2
# - com.google.code.findbugs:annotations:3.0.1 wanted version 3.0.1
# - com.google.guava:guava:23.0 wanted version 1.3.9
# - io.grpc:grpc-core:1.15.0 wanted version 3.0.0
    {"artifact": "com.google.code.findbugs:jsr305:2.0.2", "lang": "java", "sha1": "516c03b21d50a644d538de0f0369c620989cd8f0", "sha256": "1e7f53fa5b8b5c807e986ba335665da03f18d660802d8bf061823089d1bee468", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/2.0.2/jsr305-2.0.2.jar", "name": "com-google-code-findbugs-jsr305", "actual": "@com-google-code-findbugs-jsr305//jar", "bind": "jar/com/google/code/findbugs/jsr305"},
    {"artifact": "com.google.code.gson:gson:2.7", "lang": "java", "sha1": "751f548c85fa49f330cecbb1875893f971b33c4e", "sha256": "2d43eb5ea9e133d2ee2405cc14f5ee08951b8361302fdd93494a3a997b508d32", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.7/gson-2.7.jar", "source": {"sha1": "bbb63ca253b483da8ee53a50374593923e3de2e2", "sha256": "2d3220d5d936f0a26258aa3b358160741a4557e046a001251e5799c2db0f0d74", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.7/gson-2.7-sources.jar"} , "name": "com-google-code-gson-gson", "actual": "@com-google-code-gson-gson//jar", "bind": "jar/com/google/code/gson/gson"},
# duplicates in com.google.errorprone:error_prone_annotations promoted to 2.2.0
# - com.google.guava:guava:23.0 wanted version 2.0.18
# - io.grpc:grpc-core:1.15.0 wanted version 2.2.0
# - io.opencensus:opencensus-api:0.12.3 wanted version 2.2.0
# - io.opencensus:opencensus-contrib-grpc-metrics:0.12.3 wanted version 2.2.0
    {"artifact": "com.google.errorprone:error_prone_annotations:2.2.0", "lang": "java", "sha1": "88e3c593e9b3586e1c6177f89267da6fc6986f0c", "sha256": "6ebd22ca1b9d8ec06d41de8d64e0596981d9607b42035f9ed374f9de271a481a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.2.0/error_prone_annotations-2.2.0.jar", "source": {"sha1": "a8cd7823aa1dcd2fd6677c0c5988fdde9d1fb0a3", "sha256": "626adccd4894bee72c3f9a0384812240dcc1282fb37a87a3f6cb94924a089496", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.2.0/error_prone_annotations-2.2.0-sources.jar"} , "name": "com-google-errorprone-error_prone_annotations", "actual": "@com-google-errorprone-error_prone_annotations//jar", "bind": "jar/com/google/errorprone/error-prone-annotations"},
    {"artifact": "com.google.guava:guava:23.0", "lang": "java", "sha1": "c947004bb13d18182be60077ade044099e4f26f1", "sha256": "7baa80df284117e5b945b19b98d367a85ea7b7801bd358ff657946c3bd1b6596", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/23.0/guava-23.0.jar", "source": {"sha1": "ed233607c5c11e1a13a3fd760033ed5d9fe525c2", "sha256": "37fe8ba804fb3898c3c8f0cbac319cc9daa58400e5f0226a380ac94fb2c3ca14", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/23.0/guava-23.0-sources.jar"} , "name": "com-google-guava-guava", "actual": "@com-google-guava-guava//jar", "bind": "jar/com/google/guava/guava"},
    {"artifact": "com.google.j2objc:j2objc-annotations:1.1", "lang": "java", "sha1": "ed28ded51a8b1c6b112568def5f4b455e6809019", "sha256": "2994a7eb78f2710bd3d3bfb639b2c94e219cedac0d4d084d516e78c16dddecf6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1.jar", "source": {"sha1": "1efdf5b737b02f9b72ebdec4f72c37ec411302ff", "sha256": "2cd9022a77151d0b574887635cdfcdf3b78155b602abc89d7f8e62aba55cfb4f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1-sources.jar"} , "name": "com-google-j2objc-j2objc-annotations", "actual": "@com-google-j2objc-j2objc-annotations//jar", "bind": "jar/com/google/j2objc/j2objc-annotations"},
    {"artifact": "com.google.protobuf:protobuf-java:3.5.1", "lang": "java", "sha1": "8c3492f7662fa1cbf8ca76a0f5eb1146f7725acd", "sha256": "b5e2d91812d183c9f053ffeebcbcda034d4de6679521940a19064714966c2cd4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1.jar", "source": {"sha1": "7235a28a13938050e8cd5d9ed5133bebf7a4dca7", "sha256": "3be3115498d543851443bfa725c0c5b28140e363b3b7dec97f4028cd17040fa4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1-sources.jar"} , "name": "com-google-protobuf-protobuf-java", "actual": "@com-google-protobuf-protobuf-java//jar", "bind": "jar/com/google/protobuf/protobuf-java"},
    {"artifact": "io.grpc:grpc-context:1.15.0", "lang": "java", "sha1": "bdfb1d0c90d83fa998a9f25976a71019aebe7bcc", "sha256": "512e99587fa389d7ba7830d91f1e2f949162814ec077073cd4d6766fa63896f7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-context/1.15.0/grpc-context-1.15.0.jar", "source": {"sha1": "ba18517ab3e41edb72ff74b20e59abb7a7833dee", "sha256": "a8634faeb270a2440368b0d4a908066dee0e9903e471358575c0fa3e39fe9323", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-context/1.15.0/grpc-context-1.15.0-sources.jar"} , "name": "io-grpc-grpc-context", "actual": "@io-grpc-grpc-context//jar", "bind": "jar/io/grpc/grpc-context"},
# duplicates in io.grpc:grpc-core fixed to 1.15.0
# - io.grpc:grpc-netty:1.15.0 wanted version [1.15.0]
# - io.grpc:grpc-protobuf-lite:1.15.0 wanted version 1.15.0
# - io.grpc:grpc-protobuf:1.15.0 wanted version 1.15.0
# - io.grpc:grpc-stub:1.15.0 wanted version 1.15.0
# - io.grpc:grpc-testing:1.15.0 wanted version [1.15.0]
    {"artifact": "io.grpc:grpc-core:1.15.0", "lang": "java", "sha1": "85863284e3c56a7f7c2cf7a01963c7f4519a5295", "sha256": "dd615ae3c01481e67adf8d346beb4979becc09af78b6662b52cc8395eb2255c0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-core/1.15.0/grpc-core-1.15.0.jar", "source": {"sha1": "bf24e9d931fbfd438a46930848946417ee6b7965", "sha256": "56706d0ebb4d4267242feeee00bb5af517fec4478167e1baf9748681b0ebc161", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-core/1.15.0/grpc-core-1.15.0-sources.jar"} , "name": "io-grpc-grpc-core", "actual": "@io-grpc-grpc-core//jar", "bind": "jar/io/grpc/grpc-core"},
    {"artifact": "io.grpc:grpc-netty:1.15.0", "lang": "java", "sha1": "091d3d80801917e34fcbfa0a7efbd8ded61bb704", "sha256": "ce41d9c750f50edabc1d1dff90e3b7934e14b71470554720e4424e30ed9b4b08", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-netty/1.15.0/grpc-netty-1.15.0.jar", "source": {"sha1": "90dd3745ce5280dd9542e78d7c9d57a12e1351e3", "sha256": "f6c26d05a4bffcba21c48980aecba9d26ea50ad6a497e4fb860060fbdb318e30", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-netty/1.15.0/grpc-netty-1.15.0-sources.jar"} , "name": "io-grpc-grpc-netty", "actual": "@io-grpc-grpc-netty//jar", "bind": "jar/io/grpc/grpc-netty"},
    {"artifact": "io.grpc:grpc-protobuf-lite:1.15.0", "lang": "java", "sha1": "aa410544171ac19ce9c7a764a492e4d34d84c8e7", "sha256": "e406279e30a4469d49398a363ae99682c46f8949b11d08b6dd32d7e0a7c964a6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf-lite/1.15.0/grpc-protobuf-lite-1.15.0.jar", "source": {"sha1": "2d1b2b08f7235943b85f4aa434001e1891c1281e", "sha256": "a3787747d2765151601898cd27e4e0b25b870bd7def1604d267ebb3fa2491ffa", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf-lite/1.15.0/grpc-protobuf-lite-1.15.0-sources.jar"} , "name": "io-grpc-grpc-protobuf-lite", "actual": "@io-grpc-grpc-protobuf-lite//jar", "bind": "jar/io/grpc/grpc-protobuf-lite"},
    {"artifact": "io.grpc:grpc-protobuf:1.15.0", "lang": "java", "sha1": "3fd81064ee583fc7613f14323f79edb43c29643b", "sha256": "792bbe5fc54272b9abb2102bb3ebc70e4a35d672690ed05e0726e6faa1c75bf4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf/1.15.0/grpc-protobuf-1.15.0.jar", "source": {"sha1": "c2f557b9f55b7a8d1c1bdd25f393d2cae13a64d1", "sha256": "8bb9f8f9c00da099f8d47625f43d5cafea58687eaf0c9cb3964415e6a67081f6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf/1.15.0/grpc-protobuf-1.15.0-sources.jar"} , "name": "io-grpc-grpc-protobuf", "actual": "@io-grpc-grpc-protobuf//jar", "bind": "jar/io/grpc/grpc-protobuf"},
    {"artifact": "io.grpc:grpc-stub:1.15.0", "lang": "java", "sha1": "17ac6d74d9bef3dec6eddbd0772fede89865261c", "sha256": "d3fa20905203778dac4db1d8a1f1230eaa8c0c42e5e4afefc0c74afb48bacbbe", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-stub/1.15.0/grpc-stub-1.15.0.jar", "source": {"sha1": "a61e3a69182fe0e43dadacf5ff37864dd5f61833", "sha256": "b713744855c7246d4e6aea33fe5e1a65c3b86209b60d7b871533edf7604daf38", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-stub/1.15.0/grpc-stub-1.15.0-sources.jar"} , "name": "io-grpc-grpc-stub", "actual": "@io-grpc-grpc-stub//jar", "bind": "jar/io/grpc/grpc-stub"},
    {"artifact": "io.grpc:grpc-testing:1.15.0", "lang": "java", "sha1": "42d5e3e1a6212003c10a2fdd2acd5f9b4205fdae", "sha256": "09afac822398271ffa21c3f41db5a3cff0fa2515ed65f606eb10d38c7e81be1d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-testing/1.15.0/grpc-testing-1.15.0.jar", "source": {"sha1": "e01824696d92c788298dd6e0d50836c30071b90d", "sha256": "f49992d5c5cc1937253a3f367c01dcf3f52ac472cdf2ec565163d978e1358d97", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-testing/1.15.0/grpc-testing-1.15.0-sources.jar"} , "name": "io-grpc-grpc-testing", "actual": "@io-grpc-grpc-testing//jar", "bind": "jar/io/grpc/grpc-testing"},
    {"artifact": "io.netty:netty-all:4.1.30.Final", "lang": "java", "sha1": "b2ec349d1605548d3f74bd68fd53e95d8dd88036", "sha256": "af76cf48e0cc481b78b0ae3e2fb03ba7abf5f1f211b27ed930122b536ce8957c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-all/4.1.30.Final/netty-all-4.1.30.Final.jar", "source": {"sha1": "4c105a22f1e71eada2f5b949101ccfa99a21786e", "sha256": "a60225a743bacea8f7020bc41da21d5ccaa7dfff4d2d68d7d686efa1be6770d2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-all/4.1.30.Final/netty-all-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-all", "actual": "@io-netty-netty-all//jar", "bind": "jar/io/netty/netty-all"},
    {"artifact": "io.netty:netty-buffer:4.1.30.Final", "lang": "java", "sha1": "597adb653306470fb3ec1af3c0f3f30a37b1310a", "sha256": "dac32e67876f416e0526c457bbb4d4a7b245d2d6977a39e3ed54484370d86d6e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-buffer/4.1.30.Final/netty-buffer-4.1.30.Final.jar", "source": {"sha1": "e7e5789c789b4f3e6069ee2ed9e5e102c7868ad8", "sha256": "16354a73bf34e4c64bb703f3b6c5dbd2c8b47a1c4a130f0e2ff25f7153d8b852", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-buffer/4.1.30.Final/netty-buffer-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-buffer", "actual": "@io-netty-netty-buffer//jar", "bind": "jar/io/netty/netty-buffer"},
    {"artifact": "io.netty:netty-codec-http2:4.1.30.Final", "lang": "java", "sha1": "2da92f518409904954d3e8dcc42eb6a562a70302", "sha256": "8636be7896f88e4d1a363875d53c8521a90913915854a3cfed0486024ba4a07f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-http2/4.1.30.Final/netty-codec-http2-4.1.30.Final.jar", "source": {"sha1": "4028134a4c155c6f83972912b9b5370a4b0a656a", "sha256": "ef3f6fe0cd4251fd5adb81bb183bf079585104b44ac42d1423db32c545ea2a41", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-http2/4.1.30.Final/netty-codec-http2-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-codec-http2", "actual": "@io-netty-netty-codec-http2//jar", "bind": "jar/io/netty/netty-codec-http2"},
    {"artifact": "io.netty:netty-codec-http:4.1.30.Final", "lang": "java", "sha1": "1384c630e8a0eeef33ad12a28791dce6e1d8767c", "sha256": "0beb4874977de5cb2b4f1e5b4f986050208c49bf485c093ae6e3681b9eba8d6c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-http/4.1.30.Final/netty-codec-http-4.1.30.Final.jar", "source": {"sha1": "218b33bae3a4e5cebe489ff65647e9ec9de58ef1", "sha256": "08e40605e479214f5aace6405912cd31bb337669f5f0cd70e8cd3bbadd5a8eca", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-http/4.1.30.Final/netty-codec-http-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-codec-http", "actual": "@io-netty-netty-codec-http//jar", "bind": "jar/io/netty/netty-codec-http"},
    {"artifact": "io.netty:netty-codec-socks:4.1.30.Final", "lang": "java", "sha1": "ea272e3bb281d3a91d27278f47e61b4de285cc27", "sha256": "cff97f4b618ab0a1a3664bc1716a98389d477f6c1412275af34cb8e60cd3f1a9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-socks/4.1.30.Final/netty-codec-socks-4.1.30.Final.jar", "source": {"sha1": "f9a0e618f41ae84734a745880d0cfd9a6d1d6f6f", "sha256": "8ccebe1622039f6eba7f856caa810c185eac936a8492ff7be9b2f0318c36f932", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-socks/4.1.30.Final/netty-codec-socks-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-codec-socks", "actual": "@io-netty-netty-codec-socks//jar", "bind": "jar/io/netty/netty-codec-socks"},
    {"artifact": "io.netty:netty-codec:4.1.30.Final", "lang": "java", "sha1": "515c8f609aaca28a94f984d89a9667dd3359c1b1", "sha256": "ca9873b1a4419dd3d5455afa8351279e5c9c834b86118c5e345ff7751492bd30", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec/4.1.30.Final/netty-codec-4.1.30.Final.jar", "source": {"sha1": "5c9148c433a3d5869981aac0b5d8ee1b83f727e6", "sha256": "c21e2f8a03ef837bf6fb7758633c7810fe02b32f12716195c1f7b016999f5497", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec/4.1.30.Final/netty-codec-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-codec", "actual": "@io-netty-netty-codec//jar", "bind": "jar/io/netty/netty-codec"},
    {"artifact": "io.netty:netty-common:4.1.30.Final", "lang": "java", "sha1": "5dca0c34d8f38af51a2398614e81888f51cf811a", "sha256": "b5f23d82aab356751db417829536267886ad835d314b4ae4425736cf8a0a9a2a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-common/4.1.30.Final/netty-common-4.1.30.Final.jar", "source": {"sha1": "bbe24e82b2e153dc9bfaa01c63c0dd47c71f2e59", "sha256": "25de2f42d1bc6809f02f14239326fcfc54109ebe9dd88dc7460e604cd90dcde5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-common/4.1.30.Final/netty-common-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-common", "actual": "@io-netty-netty-common//jar", "bind": "jar/io/netty/netty-common"},
    {"artifact": "io.netty:netty-handler-proxy:4.1.30.Final", "lang": "java", "sha1": "1baa1568fa936caddca0fae96fdf127fd5cbad16", "sha256": "8553f0eaac3a21f25e485eb5191d21c69837deb5acc74b9cdf987820eaee3b54", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-handler-proxy/4.1.30.Final/netty-handler-proxy-4.1.30.Final.jar", "source": {"sha1": "88ef22e28a471ffe6f845c6971b56a7fcc446199", "sha256": "11b233fc1998b9c7960af1520cba1d3de181ed938d12efed1b28abda2b9ebdb3", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-handler-proxy/4.1.30.Final/netty-handler-proxy-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-handler-proxy", "actual": "@io-netty-netty-handler-proxy//jar", "bind": "jar/io/netty/netty-handler-proxy"},
    {"artifact": "io.netty:netty-handler:4.1.30.Final", "lang": "java", "sha1": "ecc076332ed103411347f4806a44ee32d9d9cb5f", "sha256": "416a61a489ebddb668a721401bb08ee0796768801ec27cf05f5e528c76236e8d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-handler/4.1.30.Final/netty-handler-4.1.30.Final.jar", "source": {"sha1": "537c70ab45c414e08aacb8c2c17e407752073ce7", "sha256": "eef70f9cf7bb8af2394be8ab86080f475a651455bd3a548092c3fd8fb35405f7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-handler/4.1.30.Final/netty-handler-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-handler", "actual": "@io-netty-netty-handler//jar", "bind": "jar/io/netty/netty-handler"},
    {"artifact": "io.netty:netty-resolver:4.1.30.Final", "lang": "java", "sha1": "5106fd687066ffd712e5295d32af4e2ac6482613", "sha256": "c975aed0421009c6f762afa4d7182eee51a9fc00f3d238f24950e2225c3e882f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-resolver/4.1.30.Final/netty-resolver-4.1.30.Final.jar", "source": {"sha1": "f2006616cc4c05263eb2c8cf3187109e1710b6dd", "sha256": "0d8d0e340394baf39e6de46d1da6df25ee06c05d7e47824bdaf19ad5b4e3b44a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-resolver/4.1.30.Final/netty-resolver-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-resolver", "actual": "@io-netty-netty-resolver//jar", "bind": "jar/io/netty/netty-resolver"},
    {"artifact": "io.netty:netty-transport:4.1.30.Final", "lang": "java", "sha1": "3d27bb432a3b125167ac161b26415ad29ec17f02", "sha256": "8b2ac95f7ad8ba53847a7724e45b5d68ebc84bb058093f493424df9fc2ecf2fa", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-transport/4.1.30.Final/netty-transport-4.1.30.Final.jar", "source": {"sha1": "de1b7fc8e484050f5879722dfe0e13378229bee4", "sha256": "d5d8e4d9845cdfa9f6bcbf52f96870963f63a94f79fb65139b4c2d33886c389c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-transport/4.1.30.Final/netty-transport-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-transport", "actual": "@io-netty-netty-transport//jar", "bind": "jar/io/netty/netty-transport"},
    {"artifact": "io.opencensus:opencensus-api:0.12.3", "lang": "java", "sha1": "743f074095f29aa985517299545e72cc99c87de0", "sha256": "8c1de62cbdaf74b01b969d1ed46c110bca1a5dd147c50a8ab8c5112f42ced802", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-api/0.12.3/opencensus-api-0.12.3.jar", "source": {"sha1": "09c2dad7aff8b6d139723b9181ba5da3f689213b", "sha256": "67e8b2120737c7dcfc61eef33f75319b1c4e5a2806d3c1a74cab810650ac7a19", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-api/0.12.3/opencensus-api-0.12.3-sources.jar"} , "name": "io-opencensus-opencensus-api", "actual": "@io-opencensus-opencensus-api//jar", "bind": "jar/io/opencensus/opencensus-api"},
    {"artifact": "io.opencensus:opencensus-contrib-grpc-metrics:0.12.3", "lang": "java", "sha1": "a4c7ff238a91b901c8b459889b6d0d7a9d889b4d", "sha256": "632c1e1463db471b580d35bc4be868facbfbf0a19aa6db4057215d4a68471746", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.12.3/opencensus-contrib-grpc-metrics-0.12.3.jar", "source": {"sha1": "9a7d004b774700837eeebff61230b8662d0e30d1", "sha256": "d54f6611f75432ca0ab13636a613392ae8b7136ba67eb1588fccdb8481f4d665", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.12.3/opencensus-contrib-grpc-metrics-0.12.3-sources.jar"} , "name": "io-opencensus-opencensus-contrib-grpc-metrics", "actual": "@io-opencensus-opencensus-contrib-grpc-metrics//jar", "bind": "jar/io/opencensus/opencensus-contrib-grpc-metrics"},
    {"artifact": "junit:junit:4.12", "lang": "java", "sha1": "2973d150c0dc1fefe998f834810d68f278ea58ec", "sha256": "59721f0805e223d84b90677887d9ff567dc534d7c502ca903c0c2b17f05c116a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/junit/junit/4.12/junit-4.12.jar", "source": {"sha1": "a6c32b40bf3d76eca54e3c601e5d1470c86fcdfa", "sha256": "9f43fea92033ad82bcad2ae44cec5c82abc9d6ee4b095cab921d11ead98bf2ff", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/junit/junit/4.12/junit-4.12-sources.jar"} , "name": "junit-junit", "actual": "@junit-junit//jar", "bind": "jar/junit/junit"},
    {"artifact": "net.bytebuddy:byte-buddy-agent:1.6.4", "lang": "java", "sha1": "f6e414aa655ae1649eb642f70ea67e2c52b196c4", "sha256": "14e602e74e8c1a072a71eb75184f45eb8014221bf4981896b8686c2034a29ef5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy-agent/1.6.4/byte-buddy-agent-1.6.4.jar", "source": {"sha1": "609e1f88a35606b8db4afcc35959b52bc099b7ba", "sha256": "a53d298ccc3670bce09632be32778479462abf7a37fe80b301ed569f1d8e593f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy-agent/1.6.4/byte-buddy-agent-1.6.4-sources.jar"} , "name": "net-bytebuddy-byte-buddy-agent", "actual": "@net-bytebuddy-byte-buddy-agent//jar", "bind": "jar/net/bytebuddy/byte-buddy-agent"},
    {"artifact": "net.bytebuddy:byte-buddy:1.6.4", "lang": "java", "sha1": "682e791335dede35d628f26465b66ccd5ba7b443", "sha256": "3798336d61857087a0c5970f9c5afae2c340939913a3a7dc98e2813387405ca8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy/1.6.4/byte-buddy-1.6.4.jar", "source": {"sha1": "073154e2215a8e09cdbf39b8914e750d3b28fc7d", "sha256": "22429809c08d608d87afdea50bdf4ad1c654887b1f6a94509102f54204ce57bf", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy/1.6.4/byte-buddy-1.6.4-sources.jar"} , "name": "net-bytebuddy-byte-buddy", "actual": "@net-bytebuddy-byte-buddy//jar", "bind": "jar/net/bytebuddy/byte-buddy"},
    {"artifact": "net.jcip:jcip-annotations:1.0", "lang": "java", "sha1": "afba4942caaeaf46aab0b976afd57cc7c181467e", "sha256": "be5805392060c71474bf6c9a67a099471274d30b83eef84bfc4e0889a4f1dcc0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/jcip/jcip-annotations/1.0/jcip-annotations-1.0.jar", "source": {"sha1": "d853625d8001c00d40abed553e670279504699f9", "sha256": "e3ad6ae439e3cf8a25372de838efaa1a95f8ef9b5053d5d94fafe89c8c09814e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/jcip/jcip-annotations/1.0/jcip-annotations-1.0-sources.jar"} , "name": "net-jcip-jcip-annotations", "actual": "@net-jcip-jcip-annotations//jar", "bind": "jar/net/jcip/jcip-annotations"},
# duplicates in org.codehaus.mojo:animal-sniffer-annotations promoted to 1.17
# - com.google.guava:guava:23.0 wanted version 1.14
# - io.grpc:grpc-core:1.15.0 wanted version 1.17
    {"artifact": "org.codehaus.mojo:animal-sniffer-annotations:1.17", "lang": "java", "sha1": "f97ce6decaea32b36101e37979f8b647f00681fb", "sha256": "92654f493ecfec52082e76354f0ebf87648dc3d5cec2e3c3cdb947c016747a53", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17.jar", "source": {"sha1": "8fb5b5ad9c9723951b9fccaba5bb657fa6064868", "sha256": "2571474a676f775a8cdd15fb9b1da20c4c121ed7f42a5d93fca0e7b6e2015b40", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17-sources.jar"} , "name": "org-codehaus-mojo-animal-sniffer-annotations", "actual": "@org-codehaus-mojo-animal-sniffer-annotations//jar", "bind": "jar/org/codehaus/mojo/animal-sniffer-annotations"},
    {"artifact": "org.hamcrest:hamcrest-all:1.3", "lang": "java", "sha1": "63a21ebc981131004ad02e0434e799fd7f3a8d5a", "sha256": "4877670629ab96f34f5f90ab283125fcd9acb7e683e66319a68be6eb2cca60de", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-all/1.3/hamcrest-all-1.3.jar", "source": {"sha1": "47e033b7ab18c5dbd5fe29fc1bd5a40afe028818", "sha256": "c53535c3d25b5bf0b00a324a5583c7dd2fed0fa6d1bbc622e2dec460c24faab3", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-all/1.3/hamcrest-all-1.3-sources.jar"} , "name": "org-hamcrest-hamcrest-all", "actual": "@org-hamcrest-hamcrest-all//jar", "bind": "jar/org/hamcrest/hamcrest-all"},
    {"artifact": "org.hamcrest:hamcrest-core:1.3", "lang": "java", "sha1": "42a25dc3219429f0e5d060061f71acb49bf010a0", "sha256": "66fdef91e9739348df7a096aa384a5685f4e875584cce89386a7a47251c4d8e9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar", "source": {"sha1": "1dc37250fbc78e23a65a67fbbaf71d2e9cbc3c0b", "sha256": "e223d2d8fbafd66057a8848cc94222d63c3cedd652cc48eddc0ab5c39c0f84df", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3-sources.jar"} , "name": "org-hamcrest-hamcrest-core", "actual": "@org-hamcrest-hamcrest-core//jar", "bind": "jar/org/hamcrest/hamcrest-core"},
    {"artifact": "org.hamcrest:hamcrest-library:1.3", "lang": "java", "sha1": "4785a3c21320980282f9f33d0d1264a69040538f", "sha256": "711d64522f9ec410983bd310934296da134be4254a125080a0416ec178dfad1c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-library/1.3/hamcrest-library-1.3.jar", "source": {"sha1": "047a7ee46628ab7133129cd7cef1e92657bc275e", "sha256": "1c0ff84455f539eb3c29a8c430de1f6f6f1ba4b9ab39ca19b195f33203cd539c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-library/1.3/hamcrest-library-1.3-sources.jar"} , "name": "org-hamcrest-hamcrest-library", "actual": "@org-hamcrest-hamcrest-library//jar", "bind": "jar/org/hamcrest/hamcrest-library"},
    {"artifact": "org.mockito:mockito-core:2.6.4", "lang": "java", "sha1": "b0fa48f9f385948a1e067dd94ab813318abb0a9e", "sha256": "21c5536a3facfe718baa802609b0c38311fedf6660430da3fd29cce1cb00dbb0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/mockito/mockito-core/2.6.4/mockito-core-2.6.4.jar", "source": {"sha1": "aa6a259b1917e2b964b87cc902058d14347e0409", "sha256": "f3ce9f4978692345ce09f9c28674279475577122cbf6cae8aca21a7e08b8195b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/mockito/mockito-core/2.6.4/mockito-core-2.6.4-sources.jar"} , "name": "org-mockito-mockito-core", "actual": "@org-mockito-mockito-core//jar", "bind": "jar/org/mockito/mockito-core"},
    {"artifact": "org.objenesis:objenesis:2.5", "lang": "java", "sha1": "612ecb799912ccf77cba9b3ed8c813da086076e9", "sha256": "293328e1b0d31ed30bb89fca542b6c52fac00989bb0e62eb9d98d630c4dd6b7c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/objenesis/objenesis/2.5/objenesis-2.5.jar", "source": {"sha1": "e2b450699731118d1498645e36577371afced20f", "sha256": "727eaf4bece2f9587702b3d64a7e091afb98ab38c87b3f36728e4fe456bdd6cb", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/objenesis/objenesis/2.5/objenesis-2.5-sources.jar"} , "name": "org-objenesis-objenesis", "actual": "@org-objenesis-objenesis//jar", "bind": "jar/org/objenesis/objenesis"},
    {"artifact": "org.slf4j:jcl-over-slf4j:1.7.20", "lang": "java", "sha1": "722d5b58cb054a835605fe4d12ae163513f48d2e", "sha256": "2980cade8b98a3a8074337256d5d80a3d14a99b47fe11705dd3246f59f4516aa", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/jcl-over-slf4j/1.7.20/jcl-over-slf4j-1.7.20.jar", "source": {"sha1": "017ebed6480ab5650d7d1d912875528e2cfa45b9", "sha256": "bdcaadee1fe9fc668e43fe2489bce9b2c6ffc0349fd143103ab71220e5074603", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/jcl-over-slf4j/1.7.20/jcl-over-slf4j-1.7.20-sources.jar"} , "name": "org-slf4j-jcl-over-slf4j", "actual": "@org-slf4j-jcl-over-slf4j//jar", "bind": "jar/org/slf4j/jcl-over-slf4j"},
    {"artifact": "org.slf4j:log4j-over-slf4j:1.7.20", "lang": "java", "sha1": "c8fee323e89bf28cb8b85d6ed1a29c5b8f52a829", "sha256": "8163fb96f3e078e49473012557bfb4f6006d76470e99100a49c16714f3a9bf7d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/log4j-over-slf4j/1.7.20/log4j-over-slf4j-1.7.20.jar", "source": {"sha1": "6527fc73b4c815923e28aa15e0a98bee31374f34", "sha256": "cee4cefb07beb55117d860deaf8f2c21b3f602d5d2d0646218feddf92ed568c2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/log4j-over-slf4j/1.7.20/log4j-over-slf4j-1.7.20-sources.jar"} , "name": "org-slf4j-log4j-over-slf4j", "actual": "@org-slf4j-log4j-over-slf4j//jar", "bind": "jar/org/slf4j/log4j-over-slf4j"},
# duplicates in org.slf4j:slf4j-api fixed to 1.7.20
# - ch.qos.logback:logback-classic:1.2.3 wanted version 1.7.25
# - org.slf4j:jcl-over-slf4j:1.7.20 wanted version 1.7.20
# - org.slf4j:log4j-over-slf4j:1.7.20 wanted version 1.7.20
# - org.slf4j:slf4j-simple:1.7.20 wanted version 1.7.20
    {"artifact": "org.slf4j:slf4j-api:1.7.20", "lang": "java", "sha1": "867d63093eff0a0cb527bf13d397d850af3dcae3", "sha256": "2967c337180f6dca88a8a6140495b9f0b8a85b8527d02b0089bdbf9cdb34d40b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.20/slf4j-api-1.7.20.jar", "source": {"sha1": "a12636375205fa54af1ec30d1ca2e6dbb96bf9bd", "sha256": "3bb14e45d8431c2bb35ffff82324763d1bed6e9b8782d48943b163e8fee2134c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.20/slf4j-api-1.7.20-sources.jar"} , "name": "org-slf4j-slf4j-api", "actual": "@org-slf4j-slf4j-api//jar", "bind": "jar/org/slf4j/slf4j-api"},
    {"artifact": "org.slf4j:slf4j-simple:1.7.20", "lang": "java", "sha1": "0c554734bbc4ab98ae705e28ff5771e8da568111", "sha256": "ba4bcd2eccaec544b954c53f675e705d48f0861ea36016e1b94d137368df7288", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-simple/1.7.20/slf4j-simple-1.7.20.jar", "source": {"sha1": "8328067d273b9081dcd2cca8a7c9ffa90be02831", "sha256": "bfc9b7531accf1f0658bedfe489c7b4e895a03045ea6ff99a82a584c48b93dc8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-simple/1.7.20/slf4j-simple-1.7.20-sources.jar"} , "name": "org-slf4j-slf4j-simple", "actual": "@org-slf4j-slf4j-simple//jar", "bind": "jar/org/slf4j/slf4j-simple"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)