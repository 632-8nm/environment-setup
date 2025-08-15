# IBus Pinyin
```shell
#!/usr/bin/bash
# 1. 更新软件包列表
sudo apt update

# 2. 安装 IBus 及中文拼音输入法
sudo apt install -y ibus ibus-pinyin ibus-gtk ibus-gtk3 ibus-clutter im-config

# 3. 设置 IBus 为系统默认输入法
im-config -n ibus

# 4. 写入环境变量配置文件 ~/.xprofile（确保 GTK/Qt 应用支持）
cat > ~/.xprofile << 'EOF'
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
EOF

# 5. 使用 gsettings 强制添加输入源（关键步骤，解决 GNOME 设置不显示问>题）
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'pinyin')]"

# 6. 重启 IBus 服务以应用配置
killall ibus-daemon 2>/dev/null || true
ibus-daemon -drx

# 7. 提示完成
echo "✅ IBus 拼音输入法已安装并配置完成！"
echo "📌 请注销或重启登录，然后使用 Win + Space 切换中文输入。"
```

