import { FastifyRequest, FastifyReply } from 'fastify';
import jwt from 'jsonwebtoken';
import { config } from '../../config';
import { UserPayload } from '../types';

export async function authMiddleware(request: FastifyRequest, reply: FastifyReply) {
  const authHeader = request.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return reply.status(401).send({ success: false, error: 'Missing or invalid authorization header' });
  }

  const token = authHeader.split(' ')[1];
  try {
    const payload = jwt.verify(token, config.jwt.secret) as UserPayload;
    (request as FastifyRequest & { user: UserPayload }).user = payload;
  } catch {
    return reply.status(401).send({ success: false, error: 'Invalid or expired token' });
  }
}
