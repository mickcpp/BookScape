package net.bookscape.model;

import java.util.LinkedList;
import java.util.List;

public class CsrfTokens {
    
    private static final int MAX_TOKENS = 2; // Dimensione massima della lista di token
    private static final long EXPIRATION_TIME_MS = 10 * 60 * 1000; // 10 minuti
    private List<CSRFToken> tokens;

    public CsrfTokens() {
        this.tokens = new LinkedList<>();
    }

    public List<CSRFToken> getTokens() {
        // Rimuove i token scaduti
        cleanExpiredTokens();
        return tokens;
    }

    public void addToken(String token) {
        if (tokens.size() >= MAX_TOKENS) {
            tokens.remove(0); // Rimuove il token più vecchio se la dimensione massima è raggiunta
        }
        tokens.add(new CSRFToken(token, System.currentTimeMillis()));
    }

    public boolean containsToken(String token) {
        cleanExpiredTokens(); // Rimuove i token scaduti prima della verifica
        return tokens.stream().anyMatch(t -> t.getToken().equals(token));
    }

    private void cleanExpiredTokens() {
        long now = System.currentTimeMillis();
        tokens.removeIf(t -> now - t.getTimestamp() > EXPIRATION_TIME_MS);
    }
    
    public void removeToken(String token) {
        tokens.removeIf(t -> t.getToken().equals(token));
    }

    private static class CSRFToken {
        private String token;
        private long timestamp;

        public CSRFToken(String token, long timestamp) {
            this.token = token;
            this.timestamp = timestamp;
        }

        public String getToken() {
            return token;
        }

        public long getTimestamp() {
            return timestamp;
        }
    }
}