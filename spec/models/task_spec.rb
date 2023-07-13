# spec/models/task_spec.rb

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    # バリデーションのテストを記述
  end

  describe 'スコープのテスト' do
    before do
      Task.create(title: 'タスク1', content: '詳細1', status: '未着手', deadline: Date.today + 1)
      Task.create(title: 'タスク2', content: '詳細2', status: '着手中', deadline: Date.today + 2)
      Task.create(title: 'タスク3', content: '詳細3', status: '完了', deadline: Date.today)
    end

    context 'タイトルのあいまい検索ができる場合' do
      it '該当タイトルのタスクが取得される' do
        tasks = Task.where('title LIKE ?', '%タスク%')
        expect(tasks.count).to eq(3)
        expect(tasks.pluck(:title)).to include('タスク1', 'タスク2', 'タスク3')
      end
    end

    context 'ステータス検索ができる場合' do
      it '該当ステータスのタスクが取得される' do
        tasks = Task.where(status: '未着手')
        expect(tasks.count).to eq(1)
        expect(tasks.first.status).to eq('未着手')
      end
    end

    context 'タイトルのあいまい検索とステータスの両方が検索できる場合' do
      it '該当タイトルかつ該当ステータスのタスクが取得される' do
        tasks = Task.where('title LIKE ?', '%タスク%').where(status: '着手中')
        expect(tasks.count).to eq(1)
        expect(tasks.first.title).to eq('タスク2')
        expect(tasks.first.status).to eq('着手中')
      end
    end

    context '締切日でソートされる場合' do
      it '締切日の昇順で取得される' do
        tasks = Task.sorted_by_deadline
        expect(tasks.count).to eq(3)
        expect(tasks.first.title).to eq('タスク3')
        expect(tasks.second.title).to eq('タスク1')
        expect(tasks.third.title).to eq('タスク2')
      end
    end
  end
end
