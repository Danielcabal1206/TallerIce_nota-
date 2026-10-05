module ChatSystem {

    // Información de endpoint UDP para voz
    struct UdpEndpoint {
        string ip;
        int port;
    };

    // Callback que el cliente registra en el servidor
    interface ClientCallback {
        // --- Notificaciones para Llamadas ---
        void onCallIncoming(string callerUsername, UdpEndpoint callerEndpoint);
        void onCallAccepted(string calleeUsername, UdpEndpoint calleeEndpoint);
        void onCallRejected(string calleeUsername, string reason);
        void onCallEnded(string username);
    };

    // Excepción personalizada
    exception UserNotFoundException { string reason; };
    exception CallFailedException { string reason; };

    // Interfaz del Servidor Ice
    interface ServerService {
        // --- Métodos del Servidor para Señalización de Llamadas 1 a 1 ---
        void requestCall(string caller, string target, UdpEndpoint callerUdp)
            throws UserNotFoundException, CallFailedException;

        void acceptCall(string callee, string caller, UdpEndpoint calleeUdp)
            throws UserNotFoundException;

        void rejectCall(string callee, string caller, string reason)
            throws UserNotFoundException;

        void endCall(string sender, string target);
    };
};