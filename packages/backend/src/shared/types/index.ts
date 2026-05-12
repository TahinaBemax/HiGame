export interface UserPayload {
  userId: string;
  phone: string;
}

export interface ApiResponse<T = unknown> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
}

export interface PaginationParams {
  page?: number;
  limit?: number;
}

export interface PaginatedResponse<T> extends ApiResponse<T[]> {
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  };
}

export type GameType = 'domino';
export type GameMode = '1v1' | '4p';
export type GameStatus = 'waiting' | 'playing' | 'finished' | 'cancelled';
export type PlayerStatus = 'joined' | 'playing' | 'afk' | 'abandoned';
export type KycStatus = 'pending' | 'verified' | 'rejected';
export type TransactionType = 'deposit' | 'withdrawal' | 'game_buy_in' | 'game_win' | 'commission' | 'refund';
export type TransactionStatus = 'pending' | 'success' | 'failed' | 'refunded';
