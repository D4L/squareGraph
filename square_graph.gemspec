Gem::Specification.new do |s|
  s.name = 'square_graph'
  s.version = '0.3.0'
  s.date = '2012-02-26'

  s.summary = 'a better 2d array'
  s.description = 'So far, you can create true\'s all over a graph that\'s either dimentioned or not.\n Later, the world!'
  s.authors = ['Austin Lee ~D4L']
  s.email = 'Austin.L.D4L@gmail.com'
  s.homepage = 'https://github.com/D4L/squareGraph'
  s.license = 'MIT'

  s.files = ["lib/square_graph.rb",
    "lib/face.rb",
    "Rakefile",
    "README.rdoc"
  ]
  s.test_files = ["spec/square_graph_spec.rb",
    "spec/face_spec.rb"
  ]
end
