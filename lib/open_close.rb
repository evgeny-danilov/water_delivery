class NotificationSender
  def send(user, message)
    EmailSender.send(user, message) if user.active?
  end
end

# ===== VS =====

class NotificationSender
  def send(user, message, sender = EmailSender.new)
    sender.send(user, message) if user.active?
  end
end

class EmailSender
  def send(user:, message:)
    # implementation for Email
  end
end

class SmsSender
  def send(user:, message:)
    # implementation for SMS
  end
end

sender = NotificationSender.new
sender.send(user, "Hello World", SmsSender.new)
