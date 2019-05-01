echo  "Test $1\c"
docker run -it --rm --name my-running-script $1 jruby -e "puts 'Hello World" | grep -q 'Hello World' && echo ' ...passed' || echo ' ...failed'
