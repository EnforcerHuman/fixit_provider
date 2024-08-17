import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/chat/domain/entities/message.dart';
import 'package:fixit_provider/features/chat/domain/usecases/get_messages.dart';
import 'package:meta/meta.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessages getMessages;
  MessageBloc(this.getMessages) : super(MessageInitial()) {
    on<GetMessagesEvent>((event, emit) async {
      try {
        await emit.forEach<List<Message>>(
          getMessages.execute(event.conversationId),
          onData: (messages) => MessagesLoaded(messages),
          onError: (error, StackTrace) =>
              MessagesError("Failed to load messages"),
        );
      } catch (e) {
        emit(MessagesError(e.toString()));
      }
    });
  }
}
