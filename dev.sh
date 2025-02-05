docker build -f Dockerfile.dev -t play-together .
docker run -p 3000:3000 -v $(pwd):/rails play-together
