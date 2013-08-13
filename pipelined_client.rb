require 'net/http/pipeline'

host = 'localhost'
port = 4567
resource = '/status'
debug = false
iterations = 20
request_count = 100

iterations.times do
  Net::HTTP.start host, port do |http|
    http.pipelining = true

    start = Time.now
    reqs = []
    request_count.times do
      reqs << Net::HTTP::Get.new(resource)
    end

    if debug
      http.pipeline reqs do |res|
        puts "#{res.code}: #{res.body[0..60].inspect}"
      end
    end

    puts "Loop time for #{request_count} requests: #{Time.now - start}"
  end
end
