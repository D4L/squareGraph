Gem::Specification.new do |s|
  s.name = 'square_graph'
  s.version = '1.0.0'
  s.date = '2012-02-26'

  s.summary = 'a better 2d array'
  s.description = 'A dimensionable graph that acts kinda like a grid. You can fill in spots with objects and then iterate over the entire grid or just objects. This is just version 1, there will be alot of neat tricks to come.'
  s.authors = ['Austin Lee ~D4L']
  s.email = 'Austin.L.D4L@gmail.com'
  s.homepage = 'https://github.com/D4L/squareGraph'
  s.license = 'MIT'

  s.files = ["lib/square_graph.rb",
    "lib/square_graph/face.rb",
    "Rakefile",
    "README.rdoc"
  ]
  s.test_files = ["spec/square_graph_spec.rb",
    "spec/face_spec.rb"
  ]
end
