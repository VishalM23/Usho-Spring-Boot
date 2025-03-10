package com.personal.usho.controller;

import com.personal.usho.model.Url;
import com.personal.usho.service.UrlService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.Optional;

@RestController
@RequestMapping("/api/url")
public class UrlController {

    @Autowired
    private UrlService urlService;

    @PostMapping("/shorten")
    public ResponseEntity<Url> shortenUrl(@RequestBody String originalUrl) {
        Url url = urlService.shortenUrl(originalUrl);
        return ResponseEntity.ok(url);
    }

    @GetMapping("/{shortUrl}")
    public ResponseEntity<String> redirect(@PathVariable String shortUrl) {
        Optional<Url> url = urlService.getOriginalUrl(shortUrl);
        return url.map(value -> ResponseEntity.ok(value.getOriginalUrl()))
                .orElseGet(() -> ResponseEntity.notFound().build());
    }
}