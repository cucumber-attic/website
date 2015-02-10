task default: [:jekyll, :spec, :assert_git_clean]

task :spec do
  sh 'bundle exec rspec'
end

task :jekyll do
  Dir['apps/*'].each do |app_path|
    jekyll_content_path = app_path + '/jekyll-content'
    if File.exists?(jekyll_content_path)
      puts "Detected jekyll app in #{app_path}"
      Dir.chdir(jekyll_content_path) do
        sh 'jekyll build'
      end
    end
  end
end

task :assert_git_clean do
  sh %{test -z "$(git status --porcelain)" || (echo "\nYou need to run rake jekyll and check in your changes!\n" && exit 1)}
end
