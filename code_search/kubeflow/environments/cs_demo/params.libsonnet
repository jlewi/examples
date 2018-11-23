local params = std.extVar('__ksonnet/params');
local globals = import 'globals.libsonnet';
local envParams = params {
  components+: {
    "t2t-code-search"+: {},
    "t2t-code-search-datagen"+: {
      githubTable: '',
    },
    "submit-preprocess-job"+: {
      githubTable: '',
    },
    "search-index-server"+: {
      indexFile: 'gs://test/index.csv',
      lookupFile: 'gs://test/somefile',
    },
  },
};

{
  components: {
    [x]: envParams.components[x] + globals
    for x in std.objectFields(envParams.components)
  },
}