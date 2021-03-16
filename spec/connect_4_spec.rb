# frozen_string_literal: true

require 'stringio'
require_relative '../lib/connect_4_game'

describe Game do
  let(:game) { Game.new }
  let(:player1) { Player.new('player1', 'R') }
  let(:player2) { Player.new('player2', 'Y') }
  describe '#place piece' do
    context 'when columnn is not full' do
      it 'places piece at lowest space marked with O of column' do
        board = game.instance_variable_get(:@board)
        game.place_piece(0, player2)
        expect(board).to eq([%w[Y O O O O O]] + [%w[O O O O O O]] * 6)
      end
      it 'returns truthy value' do
        returned_value = game.place_piece(0, player2)
        expect(returned_value).to be_truthy
      end
    end
    context 'when column is full' do
      before do
        game.instance_variable_set(:@board, [%w[Y R Y R Y R], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O]])
      end
      it 'returns false' do
        returned_value = game.place_piece(0, player2)
        expect(returned_value).to eq(false)
      end
      it 'does not change' do
        expect { game.place_piece(0, player2) }.not_to(change { game.instance_variable_get(:@board) })
      end
    end
    context 'when invalid value is used' do
      it 'returns false' do
        returned_value = game.place_piece(99, player2)
        expect(returned_value).to eq(false)
      end
    end
  end
  describe '#check_win' do
  end
  describe '#check_vertical' do
    context 'when there is a vertical row of 4' do
      before do
        game.instance_variable_set(:@board, [%w[Y Y Y Y O O], %w[R R R O O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O]])
      end
      it 'returns true' do
        win = game.check_vertical(player2)
        expect(win).to eq(true)
      end
      it 'sets @winner to winning player' do
        game.check_vertical(player2)
        winner = game.instance_variable_get(:@winner)
        expect(winner).to eq(player2)
      end
    end
    context 'when there is no vertical row of 4' do
      before do
        game.instance_variable_set(:@board, [%w[Y Y R Y O O], %w[R R R Y O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O]])
      end
      it 'returns false' do
        win = game.check_vertical(player2)
        expect(win).to eq(false)
      end
      it 'does not set @winner' do
        game.check_vertical(player2)
        winner = game.instance_variable_get(:@winner)
        expect(winner).to eq(nil)
      end
    end
  end
  describe '#check_horizontal' do
    context 'when there is a horizontal row of 4' do
      before do
        game.instance_variable_set(:@board, [%w[Y Y R Y O O], %w[R R R Y O O], %w[Y Y R O O O], %w[R Y R O O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O]])
      end
      it 'returns true' do
        win = game.check_horizontal(player1)
        expect(win).to eq(true)
      end
      it 'sets @winner to winning player' do
        game.check_horizontal(player1)
        winner = game.instance_variable_get(:@winner)
        expect(winner).to eq(player1)
      end
    end
    context 'when there is no  horizontal row of 4' do
      before do
        game.instance_variable_set(:@board, [%w[Y Y R Y O O], %w[R R Y Y O O], %w[Y Y R O O O], %w[R Y R O O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O]])
      end
      it 'returns false' do
        win = game.check_horizontal(player1)
        expect(win).to eq(false)
      end
      it 'does not set @winner' do
        game.check_horizontal(player1)
        winner = game.instance_variable_get(:@winner)
        expect(winner).to eq(nil)
      end
    end
  end
  describe '#check_diagonal' do
    context 'when there is a diagonal row of 4' do
      before do
        game.instance_variable_set(:@board, [%w[Y Y R Y O O], %w[R Y R Y O O], %w[Y Y Y O O O], %w[R Y R Y O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O]])
      end
      it 'returns true' do
        win = game.check_diagonal(player2)
        expect(win).to eq(true)
      end
      it 'sets @winner to winning player' do
        game.check_diagonal(player2)
        winner = game.instance_variable_get(:@winner)
        expect(winner).to eq(player2)
      end
    end
    context 'when there is no diagonal row of 4' do
      before do
        game.instance_variable_set(:@board, [%w[R Y R Y O O], %w[R Y R Y O O], %w[Y Y Y O O O], %w[R Y R Y O O], %w[O O O O O O], %w[O O O O O O], %w[O O O O O O]])
      end
      it 'returns false' do
        win = game.check_diagonal(player2)
        expect(win).to eq(false)
      end
      it 'does not set @winner' do
        game.check_diagonal(player2)
        winner = game.instance_variable_get(:@winner)
        expect(winner).to eq(nil)
      end
    end
  end
  describe '#check_piece' do
    context 'when #place_piece returns false twice' do
      let(:input) { StringIO.new("1\n1\n2\n") }
      before do
        allow(game).to receive(:place_piece).and_return(false, false, true)
        allow(game).to receive(:puts).with('Enter column to place your piece').exactly(3).times
      end
      it 'puts error message twice' do
        error_message = 'Invalid column or column is full please enter column'
        expect(game).to receive(:puts).with(error_message).twice
        game.check_piece(player1)
      end
    end
    context 'when #place_piece returns true' do
      let(:input) { StringIO.new("2\n") }
      before do
        allow(game).to receive(:place_piece).and_return(true)
        allow(game).to receive(:puts).with('Enter column to place your piece')
      end
      it 'does not put error message' do
        error_message = 'Invalid column or column is full please enter column'
        expect(game).not_to receive(:puts).with(error_message)
      end
    end
  end
end
