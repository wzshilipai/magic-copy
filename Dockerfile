FROM node:lts AS builder

COPY . /app

WORKDIR /app

RUN npm ci
RUN npm run build

RUN ./buildcrx.sh -d dist

FROM scratch
docker build -t segment-anything .
docker run --gpus all -p 8000:8000 segment-anything
COPY --from=builder /app/output/dist.crx /dist.crx
