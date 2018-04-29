local env = std.extVar("__ksonnet/environments");
local k = import "k.libsonnet";
local daemon = import "prepull-daemon.libsonnet";
local params = std.extVar("__ksonnet/params").components["prepull-daemon"];
local updatedParams = params + {
  imageList: [
    {
      name: "notebook",
      image: params.notebookImage,
    },
    {
      name: "t2t-trainer",
      image: params.t2tTrainerImage,
    },
  ],
};

std.prune(k.core.v1.list.new(daemon.parts(updatedParams, env)))