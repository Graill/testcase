version: '3'
services:
  
  #PHP Service
  app1:
    build:
      context: .
      dockerfile: Dockerfile
    image: dcustomimage
    container_name: app1
    restart: unless-stopped
    environment:
      SERVICE_NAME: app1
    ports:  
      - "5001:5000"  
    networks:
      - app-network
	  
  app2:
    build:
      context: .
      dockerfile: Dockerfile
    image: customimage
    container_name: app2
    restart: unless-stopped
    ports:  
      - "5002:5000"  
    environment:
      SERVICE_NAME: app2
    networks:
      - app-network	  

  #Nginx
  webserver:
    image: nginx:alpine
    container_name: webserver
    restart: unless-stopped
    tty: true
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    networks:
      - app-network

  #SQL
  db:
    image: percona/percona-server:5.7
    container_name: db
    restart: unless-stopped
    tty: true
    ports:
      - "3306:3306"
    volumes:
      - /var/log/mysql
      - /var/lib/mysql
    networks:
      - app-network

#Docker Networks
networks:
  app-network:
