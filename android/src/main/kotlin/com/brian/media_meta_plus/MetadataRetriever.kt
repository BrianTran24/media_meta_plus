package com.alexmercerind.flutter_media_metadata

import android.media.MediaMetadataRetriever

class MetadataRetriever() : MediaMetadataRetriever() {
    fun setFilePath(filePath: String?) {
        setDataSource(filePath)
    }

    val metadata: HashMap<String, Any?>
        get() {
            val metadata: HashMap<String, Any?> = HashMap()
            metadata["trackName"] = extractMetadata(METADATA_KEY_TITLE)
            metadata["trackArtistNames"] = extractMetadata(METADATA_KEY_ARTIST)
            metadata["albumName"] = extractMetadata(METADATA_KEY_ALBUM)
            metadata["albumArtistName"] =
                extractMetadata(METADATA_KEY_ALBUMARTIST)
            val trackNumber: String? =
                extractMetadata(METADATA_KEY_CD_TRACK_NUMBER)
            try {
                metadata["trackNumber"] = trackNumber!!.split("/".toRegex())
                    .dropLastWhile { it.isEmpty() }
                    .toTypedArray().get(0).trim { it <= ' ' }
                metadata.put(
                    "albumLength",
                    trackNumber.split("/".toRegex())
                        .dropLastWhile { it.isEmpty() }
                        .toTypedArray().get(
                            trackNumber.split("/".toRegex())
                                .dropLastWhile { it.isEmpty() }
                                .toTypedArray().size - 1
                        ).trim { it <= ' ' })
            } catch (error: Exception) {
                metadata.put("trackNumber", null)
                metadata.put("albumLength", null)
            }
            val year: String? = extractMetadata(METADATA_KEY_YEAR)
            val date: String? = extractMetadata(METADATA_KEY_DATE)
            try {
                metadata.put("year", year!!.trim { it <= ' ' }.toInt())
            } catch (yearException: Exception) {
                try {
                    metadata.put(
                        "year",
                        date!!.split("-".toRegex())
                            .dropLastWhile { it.isEmpty() }
                            .toTypedArray().get(0).trim { it <= ' ' })
                } catch (dateException: Exception) {
                    metadata.put("year", null)
                }
            }
            metadata.put("genre", extractMetadata(METADATA_KEY_GENRE))
            metadata.put("authorName", extractMetadata(METADATA_KEY_AUTHOR))
            metadata.put("writerName", extractMetadata(METADATA_KEY_WRITER))
            metadata.put(
                "discNumber",
                extractMetadata(METADATA_KEY_DISC_NUMBER)
            )
            metadata.put("mimeType", extractMetadata(METADATA_KEY_MIMETYPE))
            metadata.put(
                "trackDuration",
                extractMetadata(METADATA_KEY_DURATION)
            )
            metadata.put("bitrate", extractMetadata(METADATA_KEY_BITRATE))
            return metadata
        }
    val albumArt: ByteArray?
        get() {
            return embeddedPicture
        }
}
