// .opencode/plugins/notification.js
export const NotificationPlugin = async ({ $ }) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        // 通知を表示
        await $`notify`.quiet()
      }
    }
  }
}
