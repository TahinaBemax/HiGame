import { Server as SocketIOServer } from 'socket.io';
import { Server as HTTPServer } from 'http';
import { redis } from '../redis/client';

let io: SocketIOServer;

export function initWebSocketGateway(httpServer: HTTPServer): SocketIOServer {
  io = new SocketIOServer(httpServer, {
    cors: {
      origin: '*',
      methods: ['GET', 'POST'],
    },
    pingTimeout: 30000,
    pingInterval: 10000,
  });

  io.on('connection', (socket) => {
    const userId = socket.handshake.query.userId as string;

    if (userId) {
      socket.join(`user:${userId}`);
      redis.set(`ws:session:${userId}`, JSON.stringify({
        socketId: socket.id,
        joinedAt: Date.now(),
      }), 'EX', 3600);
    }

    socket.on('disconnect', () => {
      if (userId) {
        redis.del(`ws:session:${userId}`);
      }
    });
  });

  return io;
}

export function getIO(): SocketIOServer {
  if (!io) throw new Error('Socket.IO not initialized');
  return io;
}
