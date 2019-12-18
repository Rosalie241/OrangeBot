using System.Collections.Generic;
using System.Threading.Tasks;
using Discord;
using Discord.WebSocket;

namespace OrangeBot.Behaviours
{
    public interface IBotBehaviour
    {
        Task OnReady() => Task.CompletedTask;
        Task OnMessageReceived(SocketMessage message) => Task.CompletedTask;
        Task OnMessageUpdated(Cacheable<IMessage, ulong> oldMessage, SocketMessage newMessage, ISocketMessageChannel channel) => Task.CompletedTask;
        Task OnMessageDeleted(Cacheable<IMessage, ulong> message, ISocketMessageChannel channel) => Task.CompletedTask;
        Task OnReactionAdded(Cacheable<IUserMessage, ulong> message, ISocketMessageChannel channel, SocketReaction reaction) => Task.CompletedTask;
        Task OnBulkMessagesDeleted(IReadOnlyCollection<Cacheable<IMessage, ulong>> messages, ISocketMessageChannel channel) => Task.CompletedTask;
        Task OnUserJoined(SocketGuildUser user) => Task.CompletedTask;
        Task OnUserLeft(SocketGuildUser user) => Task.CompletedTask;
        Task OnUserBanned(SocketUser user, SocketGuild guild) => Task.CompletedTask;
        Task OnUserUnbanned(SocketUser user, SocketGuild guild) => Task.CompletedTask;
    }
}