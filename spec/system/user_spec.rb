require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  # describe '登録機能' do
  #   context 'ユーザを登録した場合' do
  #     it '新規登録ができる' do
  #       visit new_user_path
  #       fill_in "user[name]", with: 'テスト'
  #       fill_in "user[email]", with: 'test100@test.com'
  #       fill_in "user[password]", with: "testtest"
  #       fill_in "user[password_confirmation]", with: "testtest"
  #       click_on "送信"
  #       expect(page).to have_content 'テスト'
  #     end
  #   end
  #   context 'ログインせずに飛ぼうとした時' do
  #     it 'ログイン画面に遷移する' do
  #       visit tasks_path
  #       expect(page).to have_content 'Log in'
  #   end
  #  end
  # end
  
  # describe 'セッションログイン機能' do
  #   it 'ログインする' do
  #       visit new_session_path
  #       fill_in "session[email]", with: 'test@desu.com'
  #       fill_in "session[password]", with: 'testtest'
  #       click_button "Log in"
  #       expect(page).to have_content 'Log in'
  #   end
  # end
  
  # context 'ログインしたユーザーが' do
  #   it 'マイページに飛べる' do
  #     FactoryBot.create(:user)
  #     visit new_session_path
  #     fill_in "session[email]", with: 'test@code.com'
  #     fill_in "session[password]", with: 'testcode'
  #     click_on "Log in"
  #     expect(page).to have_content 'ページ'
  #   end
  # end
  # context '一般ユーザーが他人の詳細画面に飛ぶと' do
  #   it 'タスク一覧画面に遷移する' do
  #       user = FactoryBot.create(:user)
  #       user2 = FactoryBot.create(:second_user)
  #       visit new_session_path
  #       fill_in "session[email]", with: 'test@code.com'
  #       fill_in "session[password]", with: 'testcode'
  #       click_on "Log in"
  #       main_window = page.driver.browser.window_handles.first
  #       new_window = page.driver.browser.window_handles.last
  #       page.driver.browser.switch_to.window(new_window)
  #       visit user_path(user2.id)
  #       expect(page).to have_content 'タスク一覧'
  #   end
  # end
  # context 'ログアウトすること' do
  #   it 'ログイン画面が見えている' do
  #       FactoryBot.create(:user)
  #     visit new_session_path
  #     fill_in "session[email]", with: 'test@code.com'
  #     fill_in "session[password]", with: 'testcode'
  #     click_on "Log in"
  #     click_on "Logout"
  #     expect(page).to have_content 'Log in'
  #   end
  # end

  describe '管理画面テスト' do
   before do
     FactoryBot.create(:three_user)
     visit new_session_path
     fill_in "session[email]", with: 'test@seed.com'
     fill_in "session[password]", with: '654321'
   end

  context '管理ユーザーが' do
    it '管理画面にアクセスできる' do
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content '管理者'     
    end
   end
 end
  context '一般ユーザーがログインの際' do
    it '管理画面に一般ユーザーはアクセスできない' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: 'test@code.com'
        fill_in "session[password]", with: 'testcode'
        click_on "Log in"
        main_window = page.driver.browser.window_handles.first
        new_window = page.driver.browser.window_handles.last
        page.driver.browser.switch_to.window(new_window)
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
    end
    context '管理ユーザーがログインしている際' do
        it 'ユーザーの新規登録できる' do
            FactoryBot.create(:three_user)
            visit new_session_path
            fill_in "session[email]", with: 'test@seed.com'
            fill_in "session[password]", with: '654321'
            click_on "Log in"
            main_window = page.driver.browser.window_handles.first
            new_window = page.driver.browser.window_handles.last
            page.driver.browser.switch_to.window(new_window)
            visit new_admin_user_path
            fill_in "user[name]", with: 'テスト君'
            fill_in "user[email]", with: 'test@test.com'
            fill_in "user[password]", with: '123456'
            fill_in "user[password_confirmation]", with: '123456'
            click_on "登録する"
            expect(page).to have_content 'test@test.com'
        end
     end
     context '管理ユーザーがログインしている際' do
        it '詳細画面にアクセス出来る' do
            FactoryBot.create(:three_user)
            visit new_session_path
            fill_in "session[email]", with: 'test@seed.com'
            fill_in "session[password]", with: '654321'
            click_on "Log in"
            main_window = page.driver.browser.window_handles.first
            new_window = page.driver.browser.window_handles.last
            page.driver.browser.switch_to.window(new_window)
            visit admin_users_path
            sleep(3)
            click_on "詳細を確認する"
            expect(page).to have_content '詳細画面'
        end
     end
     context '管理ユーザーがログインしている際' do
        it 'ユーザー詳細にアクセスできる' do
            FactoryBot.create(:three_user)
            FactoryBot.create(:four_user)
            visit new_session_path
            fill_in "session[email]", with: 'test@seed.com'
            fill_in "session[password]", with: '654321'
            click_on "Log in"
            main_window = page.driver.browser.window_handles.first
            new_window = page.driver.browser.window_handles.last
            page.driver.browser.switch_to.window(new_window)
            visit admin_users_path
            click_on "ユーザーを編集する",match: :first
            fill_in "user[name]", with: 'テスト君'
            fill_in "user[email]", with: 'test1@test.com'
            click_on "commit"
            expect(page).to have_content "一覧画面"
        end
     end
     context '管理ユーザーログインしている際' do
        it 'ユーザーの削除が出来る' do
            FactoryBot.create(:three_user)
            FactoryBot.create(:user)
            visit user_path(:three_user)
            fill_in "session[email]", with: 'test@seed.com'
            fill_in "session[password]", with: '654321'
            click_on "Log in"
            main_window = page.driver.browser.window_handles.first
            new_window = page.driver.browser.window_handles.last
            page.driver.browser.switch_to.window(new_window)
            visit admin_users_path
            click_on "ユーザーを削除する",match: :first
            visit admin_users_path
            expect(page).to have_content '一覧画面'
        end
     end
   end
end