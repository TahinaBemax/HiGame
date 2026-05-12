-- CreateEnum
CREATE TYPE "KycStatus" AS ENUM ('pending', 'verified', 'rejected');

-- CreateEnum
CREATE TYPE "KycDocType" AS ENUM ('cin', 'permis');

-- CreateEnum
CREATE TYPE "TransactionType" AS ENUM ('deposit', 'withdrawal', 'game_buy_in', 'game_win', 'commission', 'refund');

-- CreateEnum
CREATE TYPE "TransactionStatus" AS ENUM ('pending', 'success', 'failed', 'refunded');

-- CreateEnum
CREATE TYPE "GameType" AS ENUM ('domino');

-- CreateEnum
CREATE TYPE "GameMode" AS ENUM ('1v1', '4p');

-- CreateEnum
CREATE TYPE "GameStatus" AS ENUM ('waiting', 'playing', 'finished', 'cancelled');

-- CreateEnum
CREATE TYPE "PlayerStatus" AS ENUM ('joined', 'playing', 'afk', 'abandoned');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "phone" VARCHAR(20) NOT NULL,
    "nickname" VARCHAR(50),
    "avatarUrl" TEXT,
    "kyc_status" "KycStatus" NOT NULL DEFAULT 'pending',
    "kyc_doc_url" JSONB,
    "password_hash" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "limits" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sessions" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "token_hash" TEXT NOT NULL,
    "device_info" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wallets" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "balance" INTEGER NOT NULL DEFAULT 0,
    "version" INTEGER NOT NULL DEFAULT 1,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "wallets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transactions" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "type" "TransactionType" NOT NULL,
    "amount" INTEGER NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'Ar',
    "status" "TransactionStatus" NOT NULL DEFAULT 'pending',
    "correlation_id" TEXT NOT NULL,
    "provider_ref" TEXT,
    "metadata" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kyc_documents" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "doc_type" "KycDocType" NOT NULL,
    "file_path" TEXT NOT NULL,
    "status" "KycStatus" NOT NULL DEFAULT 'pending',
    "rejection_reason" TEXT,
    "verified_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "kyc_documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "games" (
    "id" TEXT NOT NULL,
    "type" "GameType" NOT NULL DEFAULT 'domino',
    "mode" "GameMode" NOT NULL,
    "stake" INTEGER NOT NULL,
    "status" "GameStatus" NOT NULL DEFAULT 'waiting',
    "commission_rate" INTEGER NOT NULL DEFAULT 12,
    "target_score" INTEGER NOT NULL DEFAULT 100,
    "rng_seed" TEXT,
    "host_id" TEXT,
    "winner_id" TEXT,
    "total_pool" INTEGER,
    "started_at" TIMESTAMP(3),
    "finished_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "games_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "game_players" (
    "id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "team" INTEGER NOT NULL DEFAULT 1,
    "seat_number" INTEGER NOT NULL,
    "status" "PlayerStatus" NOT NULL DEFAULT 'joined',
    "final_score" INTEGER,
    "joined_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "game_players_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "game_events" (
    "id" BIGSERIAL NOT NULL,
    "game_id" TEXT NOT NULL,
    "event_type" TEXT NOT NULL,
    "player_id" TEXT,
    "payload" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "game_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "game_snapshots" (
    "game_id" TEXT NOT NULL,
    "state" JSONB,
    "version" INTEGER NOT NULL DEFAULT 1,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "game_snapshots_pkey" PRIMARY KEY ("game_id")
);

-- CreateTable
CREATE TABLE "idempotency_keys" (
    "key" TEXT NOT NULL,
    "response" JSONB,
    "expires_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "idempotency_keys_pkey" PRIMARY KEY ("key")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_phone_key" ON "users"("phone");

-- CreateIndex
CREATE INDEX "idx_sessions_expires" ON "sessions"("expires_at");

-- CreateIndex
CREATE UNIQUE INDEX "wallets_user_id_key" ON "wallets"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "transactions_correlation_id_key" ON "transactions"("correlation_id");

-- CreateIndex
CREATE INDEX "idx_transactions_user_id" ON "transactions"("user_id");

-- CreateIndex
CREATE INDEX "idx_transactions_correlation" ON "transactions"("correlation_id");

-- CreateIndex
CREATE INDEX "idx_transactions_status" ON "transactions"("status");

-- CreateIndex
CREATE INDEX "idx_games_status" ON "games"("status");

-- CreateIndex
CREATE INDEX "idx_game_players_game" ON "game_players"("game_id");

-- CreateIndex
CREATE INDEX "idx_game_events_game" ON "game_events"("game_id");

-- CreateIndex
CREATE INDEX "idx_game_events_created" ON "game_events"("created_at");

-- CreateIndex
CREATE INDEX "idx_idempotency_key" ON "idempotency_keys"("key");

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wallets" ADD CONSTRAINT "wallets_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kyc_documents" ADD CONSTRAINT "kyc_documents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "games" ADD CONSTRAINT "games_host_id_fkey" FOREIGN KEY ("host_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "games" ADD CONSTRAINT "games_winner_id_fkey" FOREIGN KEY ("winner_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_players" ADD CONSTRAINT "game_players_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_players" ADD CONSTRAINT "game_players_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_events" ADD CONSTRAINT "game_events_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_events" ADD CONSTRAINT "game_events_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_snapshots" ADD CONSTRAINT "game_snapshots_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE CASCADE ON UPDATE CASCADE;
