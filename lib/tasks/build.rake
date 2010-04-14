task :build => ['db:test:load', 'test', 'metrics:all']
